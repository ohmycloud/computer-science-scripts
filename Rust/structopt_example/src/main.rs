use std::path::PathBuf;
use structopt::StructOpt;

/// 第一行
///
/// 第二行
/// 第三行
/// 第四行
#[derive(Debug, StructOpt)]
#[structopt(name = "example")]
struct Opt {
    /// Activate debug mode
    // short and long flags (-d, --debug) will be deduced from the field's name
    #[structopt(short, long, help = "调试模式")]
    debug: bool,

    /// Set speed
    // we don't want to name it "speed", need to look smart
    #[structopt(short = "v", long = "velocity", default_value = "42")]
    speed: f64,

    /// Input file
    #[structopt(parse(from_os_str))]
    input: PathBuf,

    /// Output file, stdout if not present
    #[structopt(parse(from_os_str))]
    output: Option<PathBuf>,

    /// Where to write the output: to `stdout` or `file`
    #[structopt(short)]
    out_type: String,

    /// File name: only required when `out-type` is set to `file`
    #[structopt(name = "FILE", required_if("out-type", "file"))]
    file_name: Option<String>,
}

fn main() {
    // cargo run
    // Finished dev [unoptimized + debuginfo] target(s) in 0.03s
    //  Running `target\debug\structopt_example.exe`
    // error: The following required arguments were not provided:
    //     <input>
    //     -o <out-type>
    //
    // USAGE:
    // structopt_example.exe <input> -o <out-type> --velocity <speed>
    
    let opt = Opt::from_args();
    println!("{:#?}", opt);
}