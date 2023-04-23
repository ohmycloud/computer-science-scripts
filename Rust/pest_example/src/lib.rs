extern crate pest;
#[macro_use]
extern crate pest_derive;

//use pest::Parser;

pub mod csv {
    #[derive(Parser)]
    #[grammar = "grammar/csv.pest"]
    pub struct CSVParser;
}

pub mod trip {
    #[derive(Parser)]
    #[grammar = "grammar/trip.pest"]
    pub struct TripParser;
}

pub mod weather {
    #[derive(Parser)]
    #[grammar = "grammar/weather.pest"]
    pub struct WeatherParser;
}

pub mod whitespace {
    #[derive(Parser)]
    #[grammar = "grammar/whitespace.pest"]
    pub struct WhiteSpaceParser;
}

pub mod sections {
    #[derive(Parser)]
    #[grammar = "grammar/sections.pest"]
    pub struct SectionParser;
}

pub mod character_class {
    #[derive(Parser)]
    #[grammar = "grammar/character_class.pest"]
    pub struct AnyParser;
}

pub mod ipconfig {
    #[derive(Parser)]
    #[grammar = "grammar/ipconfig.pest"]
    pub struct IpconfigParser;
}

pub mod mina_log {
    #[derive(Parser)]
    #[grammar = "grammar/chargelog.pest"]
    pub struct MinalogParser;
}

