use std::env;
use structopt::StructOpt;
use chrono::{FixedOffset, NaiveDateTime, TimeZone};



//unixtimestamp 转 日期时间(指定风格符的格式)
//日期时间转 unixtimestamp(日期时间可以接收多种格式)
//注意时区

/// A command line used to convert unix timestamp and datetime
#[derive(Debug, StructOpt)]
struct Opt {
    /// unix timestamp
    #[structopt(short,long, help = "10位或13位的 unix 时间戳")]
    unixtime: String,
    /// datetime
    #[structopt(short, long, help = "日期时间")]
    datetime: String
}

fn main() {
    // for argument in env::args() {
    //     println!("{:?}", argument);
    // }

    let opt = Opt::from_args();
    println!("{:?}", opt); // Opt { unixtime: "1234567890", datetime: "2021-05-08 17:10:12" }

    
    let unixtime = opt.unixtime.trim();
    let datetime = opt.datetime.trim();

    println!("{:?} {:?}", unixtime, datetime);

    let seconds = unixtime.parse::<i64>().unwrap() as i64 + 3600 * 8 as i64;
    // 将 unixtimestamp 转换位 datetime
    let datetime_from_unixtime = NaiveDateTime::from_timestamp(seconds, 0);

    
    println!("{:?}", datetime_from_unixtime.format("%Y-%m-%d %H:%M:%S").to_string());

    let formatter = "%Y-%m-%d %H:%M:%S";
    // let no_timezone = NaiveDateTime::parse_from_str(&datetime[..], formatter);
    let yes_timezone =  FixedOffset::east(8 * 3600).datetime_from_str(&datetime[..], formatter);

    // 如果解析成功, 则取出 dt
    // if let Ok(dt) = no_timezone {
    //     let d = DateTime::<FixedOffset>::from_utc(dt, FixedOffset::east(8*3600));
    //     println!("{:?}", d);
    //     println!("{:?} {:?}", dt.timestamp(), d.timestamp());
    // }

    if let Ok(dt) = yes_timezone {
        println!("{:?} {:?}", dt, dt.timestamp());
    }
}