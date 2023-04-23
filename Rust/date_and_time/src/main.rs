
use chrono::{FixedOffset, Local, NaiveDate, NaiveDateTime, TimeZone, DateTime};

fn main() {
    let date_time: NaiveDateTime = NaiveDate::from_ymd(2021, 5, 8).and_hms(11, 33, 44);
    println!(
        "Number of seconds between 1970-01-01 00:00:00 and {} is {}.",
        date_time, date_time.timestamp());

    let date_time_after_a_billion_seconds = NaiveDateTime::from_timestamp(1620473624, 0);
    println!(
        "Date after a billion seconds since 1970-01-01 00:00:00 was {}.",
        date_time_after_a_billion_seconds);

    let local_dt = Local.ymd(2021, 5, 8); 
    println!("{:?}", local_dt);

    let fixed_dt = FixedOffset::east(8 * 3600).ymd(2021, 5, 8).and_hms(16, 44, 23);
    println!("{:?}", fixed_dt);

    let date_only = NaiveDate::parse_from_str("2021-05-08", "%Y-%m-%d");
    println!("{:?}", date_only);

    let no_timezone = NaiveDateTime::parse_from_str("2021-05-08 23:56:04", "%Y-%m-%d %H:%M:%S");

    // 如果解析成功, 则取出 dt
    if let Ok(dt) = no_timezone {
        println!("{:?}", dt.timestamp());
    }
}
