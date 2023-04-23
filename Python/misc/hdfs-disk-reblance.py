import json
import os
import click

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

            disks.append(disk_info)
    return disks

def test_plan(json_str, disks):
    print(json_str)
    data = json.loads(json_str)
    nodeName = data['nodeName']
    for plan in data['volumeSetPlans']:
        bandwidth = plan['bandwidth']
        source_path = plan['sourceVolume']['path']
        destination_path = plan['destinationVolume']['path']
        bytes_to_move = plan['bytesToMove'] / 1024.0 / 1024.0 / 1024.0

        source_usage = 0
        destination_usage = 0
        for disk in disks:
            mounted = disk['Mounted']
            if (mounted in source_path):
                source_usage = disk['Use']
            if (mounted in destination_path):
                destination_usage = disk['Use']

        prompt_text = f"source_path={source_path}, destination_path={destination_path}, bytes_to_move={bytes_to_move}, source_usage={source_usage}%, destination_usage={destination_usage}%"
        if (source_usage > destination_usage):
            print("YES: ", prompt_text)
            return True
        else:
            print("NO: ", prompt_text)
            return False


@click.command()
@click.option('--host-name', type=click.Choice(['host1', 'host2', 'host3', 'host4', 'host5', 'host6'], case_sensitive=True), help='name of host')
@click.option('--threshold-percentage', help='threshold-percentage')
@click.option('--bandwidth', type=click.Choice(['50','40','30','20','10']), help='bandwidth')
def hdfs_diskbalancer(host_name, threshold_percentage, bandwidth):
    print(f"hdfs diskbalancer at hostname={host_name} with thresholdPercentage={threshold_percentage} and bandwidth={bandwidth}")
    f2 = os.popen(f"sudo -su hdfs hdfs diskbalancer -plan {host_name} -thresholdPercentage {threshold_percentage} -bandwidth {bandwidth} 2>&1 | grep -v INFO | grep diskbalancer")
    diskbalancer_plan = ""
    for j in f2.read().split("\n"):
        if "diskbalancer" in j:
            diskbalancer_plan = j

    if ("diskbalancer" in diskbalancer_plan):
        print(f"{host_name} - diskbalancer plan json path: {diskbalancer_plan}")
        json_str = os.popen(f"sudo -su hdfs hdfs dfs -cat {diskbalancer_plan}").read()
        if ("volumeSetPlans" in json_str):
            disks = disk_info(host_name)
            test_plan(json_str, disks)
            print(f"Check again before execute the plan: sudo -su hdfs hdfs diskbalancer -execute {diskbalancer_plan}")
        else:
            println("plan is not ok")
    else:
        print('Can\'t generate plan')

# HDFS 磁盘间平衡辅助程序
# python hdfs-disk-rebanlance.py --threshold-percentage=1 --bandwidth=50 --host-name=host3
if __name__ == '__main__':
    hdfs_diskbalancer()