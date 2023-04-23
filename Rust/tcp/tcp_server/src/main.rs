use std::net::SocketAddr;
use clap::Parser;
use tokio::net::TcpListener;
use tokio::io::{AsyncReadExt, AsyncWriteExt};

/// A program for listening a socket
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
        /// 接收字节数据的主机地址
        #[clap(short, long)]
        host: String,
        /// 主机端口
        #[clap(short, long, default_value_t = 5000)]
        port: u16
}

/// https://www.reddit.com/r/rust/comments/fsnw6v/concurrent_tcp_server_with_tokio/
#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args = Args::parse();
    let listener = TcpListener::bind(format!("{}:{}", args.host, args.port)).await?;

        loop {
            let (mut socket, _) = listener.accept().await?;
    
            tokio::spawn(async move {
                let mut buf = [0; 1024];
    
                // In a loop, read data from the socket and write the data back.
                loop {
                    let n = match socket.read(&mut buf).await {
                        // socket closed
                        Ok(n) if n == 0 => return,
                        Ok(n) => n,
                        Err(e) => {
                            eprintln!("failed to read from socket; err = {:?}", e);
                            return;
                        }
                    };

                    println!("read data of: {:?}", &buf[0..n]);
    
                    // Write the data back
                    // if let Err(e) = socket.write_all(&buf[0..n]).await {
                    //     eprintln!("failed to write to socket; err = {:?}", e);
                    //     return;
                    // }
                }
            });
        }    
}

