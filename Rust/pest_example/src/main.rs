use std::fs;
use pest::error::Error;
use pest::{Parser, RuleType};
use pest_example::mina_log;
use pest_example::mina_log::MinalogParser;
use pest_example::csv;
use pest_example::character_class;
use pest_example::trip;
use pest_example::ipconfig;
use pest_example::weather;
use pest_example::whitespace;

fn main() {
    // parse_trip();
    // parse_weather();
    // parse_whitespace();
    // parse_section(); // ToDo
    // parse_character_class();
    // ipconfig_parse();
    mina_log_parse();
}

/*
fn parse_csv() {
    let succ_match = CSVParser::parse(Rule::field, "-273.15");
    if let Ok(match_res) = succ_match {
        println!("{:?}", match_res);
    }

    let unsucc_match = CSVParser::parse(Rule::field, "a jump fox");
    if let Err(e) = unsucc_match {
        println!("{:?}", e);
    }

    // read csv file
    let f = fs::read_to_string("test.csv").expect("can not read file");
    
    let parse_file = CSVParser::parse(Rule::file, &f).unwrap().next().unwrap();
    println!("{:?}", parse_file);

    let mut record_count = 0;
    let mut sum: f64 = 0.0;

    // iterate each item
    for record in parse_file.into_inner() {
        match record.as_rule() {
            Rule::record => {
                record_count += 1;

                // 累加字段值
                for field in record.into_inner() {
                    sum += field.as_str().parse::<f64>().unwrap();
                    //  println!("field = {:?}", field.as_str().parse::<f64>().unwrap());
                } 

            },
            Rule::EOI => (),
            _ => unreachable!(),
        }
    }
    

    println!("record count = {:?}", record_count);
    println!("sum = {:?}", sum);
}

fn parse_trip() {
    // read trip data
    let f = fs::read_to_string("trip.txt").unwrap();
    println!("{:?}", f);
    let trip_parse = TripParser::parse(Rule::trip, &f).unwrap().next().unwrap();
    let mut country_num = 0;

    // loop over trips
    for trip in trip_parse.into_inner() {
        match trip.as_rule() {
            Rule::country => {
                country_num += 1;

            },
            Rule::EOI => (),
            _ => unreachable!(),
        }
    }

    println!("Trip to {:?} countries", country_num);
}

fn parse_weather() {
    // read trip data
    let f = fs::read_to_string("weather.txt").unwrap();
    let weather = WeatherParser::parse(Rule::TOP, &f).unwrap().next().unwrap();
    println!("{:?}", weather);
}

fn parse_whitespace() {
    // read trip data
    let f = fs::read_to_string("whitespace.txt").unwrap();
    let whitespace = WhiteSpaceParser::parse(Rule::file, &f).unwrap().next().unwrap();
    println!("{:?}", whitespace);
}

fn parse_section() {
    // read section data
    let f = fs::read_to_string("sections.txt").unwrap();
    let sections = SectionParser::parse(Rule::TOP, &f).unwrap().next().unwrap();
    println!("{:?}", sections);
}

fn parse_character_class() {
    // setup a &str
    const EXPRESSION: &str =
        "a.b
        ";
    let character_class = AnyParser::parse(Rule::character_class, EXPRESSION);
    println!("{:?}", character_class);
}

fn ipconfig_parse() {
    let f = fs::read_to_string("ipconfig.txt").unwrap();
    let ipconfig = IpconfigParser::parse(Rule::TOP, &f).unwrap().next().unwrap();
    println!("{:?}", ipconfig);
}
*/
fn mina_log_parse() {
    let f = fs::read_to_string("minalog.txt").unwrap();
    let mina_log = MinalogParser::parse(Rule::MINALOG, &f).unwrap().next().unwrap();
    for line in mina_log.into_inner() {
        match line.as_rule() {
            Rule::mlog => {
                let inner_rules = line.into_inner().next().unwrap();
                println!("{:?}", inner_rules);
            }
            Rule::heartbeat_log => {
                println!("heart {:?}", line);
            }
            Rule::message_log => {
                println!("body {:?}", line);
            }

            _ => { println!("{:?}", "---"); }
        }
    }
}
