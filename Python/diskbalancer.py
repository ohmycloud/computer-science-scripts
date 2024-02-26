import json
import os
import click
from dataclasses import dataclass
from rich.console import Console
from rich.table import Table
import logging
from rich.logging import RichHandler

FORMAT = "%(message)s"
logging.basicConfig(
    level="NOTSET", format=FORMAT, datefmt="[%X]", handlers=[RichHandler()]
)

logger = logging.getLogger("rich")

@dataclass
class DiskUsage:
    hostname: str
    filesystem: str
    size: int
    used: int
    avail: int
    use_percent: int
    mounted: str

@dataclass
class VolumeSetPlans:
    hostname: str
    source_path: str
    destination_path: str
    plan_ok: bool


def disk_info(host_name):
    disks = []
    f = os.popen(f"ssh {host_name} df -h | grep data")
    for i in f.read().split("\n"):
        if (len(i) > 0):
            usage = i.split()
            disk_info = {}
            disk_info['host_name'] = host_name
            disk_info['Filesystem'] = usage[0]
            disk_info['Size'] = usage[1]
            disk_info['Used'] = usage[2]
            disk_info['Avail'] = usage[3]
            disk_info['Use'] = int(usage[4].strip('%'))
            disk_info['Mounted'] = usage[5]

            disk_usage = DiskUsage(
                hostname=host_name,
                filesystem=usage[0],
                size=usage[1],
                used=usage[2],
                avail=usage[3],
                use_percent=int(usage[4].strip('%')),
                mounted=usage[5]
            )
            logger.info(disk_usage)
            disks.append(disk_usage)
    return disks

def test_plan(json_str, disks):
    console = Console()
    table = Table(show_header=True, header_style="bold magenta")
    table.add_column('Host Name')
    table.add_column('Source Path')
    table.add_column('Destination Path')
    table.add_column('Source Avail', justify="right")
    table.add_column('Destination Avail', justify="right")
    table.add_column('Source Usage', justify="right")
    table.add_column('Destination Usage', justify="right")
    table.add_column('Bytes to Move', justify="right")

    console.print_json(json_str)
    data = json.loads(json_str)
    node_name = data['nodeName']

    volume_set_plans = []

    for plan in data['volumeSetPlans']:
        bandwidth = plan['bandwidth']
        source_path = plan['sourceVolume']['path']           # /mnt/data2/dfs/dn/
        destination_path = plan['destinationVolume']['path'] # /mnt/data3/dfs/dn/
        bytes_to_move = plan['bytesToMove'] / 1024.0 / 1024.0 / 1024.0

        source_usage = 0
        destination_usage = 0
        source_avail = '0'
        destination_avail = '0'

        for disk in disks:
            mounted = disk.mounted

            if (mounted in source_path):
                source_usage = disk.use_percent
                source_avail = disk.avail
            if (mounted in destination_path):
                destination_usage = disk.use_percent
                destination_avail = disk.avail

        end_with_unit = [i.endswith('G') for i in [source_avail, destination_avail]]

        plan_ok = False
        if (source_usage > destination_usage and all(end_with_unit) and int(source_avail.strip('G')) < int(destination_avail.strip('G'))):
            plan_ok = True

        volume_set_plans.append(VolumeSetPlans(
            hostname=node_name,
            source_path=source_path,
            destination_path=destination_path,
            plan_ok=plan_ok
        ))

        table.add_row(
            node_name, source_path, destination_path, source_avail, destination_avail, f"{source_usage}%", f"{destination_usage}%", f"{bytes_to_move:.2f}G"
        )
    console.print(table)

    all_plans = [i.plan_ok for i in volume_set_plans]
    if (all(all_plans)):
        return True
    else:
        return False


@click.command()
@click.option('--host-name', type=click.Choice(['host1', 'host2', 'host3', 'host4', 'host5', 'host6', 'host7', 'host9'], case_sensitive=True), help='name of host')
@click.option('--threshold-percentage', default='1', help='threshold-percentage')
@click.option('--bandwidth', type=click.Choice(['50','40','30','20','10']), default='50', help='bandwidth')
def hdfs_diskbalancer(host_name, threshold_percentage, bandwidth):
    logger.info(f"hdfs diskbalancer at hostname={host_name} with thresholdPercentage={threshold_percentage} and bandwidth={bandwidth}")
    f2 = os.popen(f"sudo -su hdfs hdfs diskbalancer -plan {host_name} -thresholdPercentage {threshold_percentage} -bandwidth {bandwidth} 2>&1 | grep -v INFO | grep diskbalancer")
    diskbalancer_plan = ""
    for j in f2.read().split("\n"):
        if "diskbalancer" in j:
            diskbalancer_plan = j

    if ("diskbalancer" in diskbalancer_plan):
        logger.info(f"{host_name} - diskbalancer plan json path: {diskbalancer_plan}")
        json_str = os.popen(f"sudo -su hdfs hdfs dfs -cat {diskbalancer_plan}").read()
        if ("volumeSetPlans" in json_str):
            disks = disk_info(host_name)
            plan = test_plan(json_str, disks)
            if plan:
                # auto execute hdfs disk rebanlance between disks
                logger.info(f"auto executing the plan: sudo -su hdfs hdfs diskbalancer -execute {diskbalancer_plan}")
                f3 = os.popen(f"sudo -su hdfs hdfs diskbalancer -execute {diskbalancer_plan}")
                logger.info(f'execute successfullly {f3.read()}')
            else:
                logger.warn(f"unable to auto execute hdfs disk plan, please do it manually!")
        else:
            logger.warn("plan is not ok")
    else:
        logger.warn('Can\'t generate plan')

if __name__ == '__main__':
    hdfs_diskbalancer()
