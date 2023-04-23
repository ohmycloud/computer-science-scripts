use aion::*;
use chrono::{TimeZone, Utc, Date, DateTime, Duration};
use chrono_tz::Asia::Shanghai;
use std::mem;

// https://github.com/jk-gan/aion
fn main() {
    // Easily represent a chrono::Duration
    let two_days = 2.days();
    println!("2 days: {:?}", two_days);
    let attention_span = 1.seconds();
    println!("Attention span: {:?}", attention_span);

    // Add or subtract durations from the current time (UTC)
    // define a timezone


    let now = Utc::now().with_timezone(&Shanghai);
    println!("now is {:?}", now);
    let three_hours_from_now = now + 3.hours();
    println!("3 hours from now: {}", three_hours_from_now);

    let two_hours_from_now = 2.hours().from_now().with_timezone(&Shanghai);
    println!("2 hours from now: {}", two_hours_from_now);

    let last_week = 7.days().ago().with_timezone(&Shanghai); // or 1.weeks().ago()
    println!("1 week ago: {}", last_week);

    // More complex DateTimes can be represented using before() and after() methods
    let christmas: DateTime<Utc> = Utc.ymd(2020, 12, 25).and_hms(0, 0, 0);
    let two_weeks_before_christmas = 2.weeks().before(christmas);
    println!("2 weeks before christmas: {}", two_weeks_before_christmas);

    let boxing_day = 1.days().after(christmas);
    println!("Boxing day: {}", boxing_day);

    // 创建一个时间范围, 2020-02-15, 2022-02-28, 步长为 5min
    let start_day: Date<Utc> = Utc.ymd(2022, 2, 15);
    let end_day: Date<Utc> = Utc.ymd(2022,2, 16);

    // 迭代日期范围 DateRange
    for i in DateRange(start_day, end_day) {
        println!("{}", i.format(&"%Y-%m-%d"));
    }
}

struct DateRange(Date<Utc>, Date<Utc>);

// https://stackoverflow.com/questions/41679239/loop-over-date-range
impl Iterator for DateRange {
    type Item = Date<Utc>;

    fn next(&mut self) -> Option<Self::Item> {
        if self.0 <= self.1 {
            let next = self.0 + Duration::days(1);
            Some(mem::replace(&mut self.0, next))
        } else {
            None
        }
    }
}
