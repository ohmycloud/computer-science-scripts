use chrono::Local;
use clap::Parser;
use std::io::Write;
use std::net::{SocketAddr, TcpStream};
use std::thread;
use std::time::Duration;

/// a tcp client
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
    #[clap(short, long)]
    host: String,
    #[clap(short, long, default_value_t = 5000)]
    port: u16,
}

fn main() {
    let args = Args::parse(); 
    let mut conn = TcpStream::connect(SocketAddr::new(args.host.parse().unwrap(), args.port)).unwrap();
    loop {
        writeln!(conn, "{}", Local::now()).unwrap();
        thread::sleep(Duration::from_secs(1));
    }
}