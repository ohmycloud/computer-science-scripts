fn main() {
    let lan = Some("Perl6");
    let rs = match lan {
        Some("Perl6") | Some("Raku")    => "100 hundred years language",
        Some("Julia") | Some("Python")  => "科学计算",
        Some("Rust")  | Some("Haskell") => "学废了",
        _ => "Programming is hard, let's go shopping",
    };
    println!("{:?}", rs);

    let rs = match lan {
        Some("Perl6" | "Raku") => "100 hundred years language",
        Some("Julia" | "Python") => "科学计算",
        Some("Rust" | "Haskell") => "学废了",
         _ => "Programming is hard, let's go shopping"
    };

    println!("{:?}", rs);

    let extension = Some("pl");
    if let Some("pm6" | "rakumod") = extension {
        println!("Perl 6 模块的后缀名");
    } else {
        println!("Perl 5???");
    }

    let vec = (-1, 0);
    match vec {
        (0, 0) => println!("here"),
        (-1 | 0 | 1, -1 | 0 | 1) => println!("close"),
        _ => println!("far away"),
    }

    let number = 42;
    let alpha = 'C';

    // 匹配范围
     match number {
        1..=12 => println!("{:?}", "1..12"),
        13..=41 => println!("{:?}", "13..41"),
        41..=45 => println!("{:?}", "41..45"),
         _ => println!("{:?}", "huep")
    }

    // 匹配字母
    match alpha {
        first@ 'A' ..= 'F' => println!("{:?}", first),
        second@ 'G' ..= 'Z' => println!("{:?}", second),
        _ => println!("{:?}", "othrers")
    }

    // 匹配数组
    let arr = [1,2,3,6];
    match arr {
        [1,2,3,_] => println!("{:?}", "head"),
        _ => println!("others")
    }

    // 匹配切片
    let slice = &[5,6,7,8];
    match slice {
        [5,6,_,8] => println!("{:?}", "slice"),
        _ => println!("others")
    }

    #[derive(Debug)]
    struct Point {x: i32, y: i32, z: i32}
    let p = Point {x: 4, y: 5, z: 56};

    // 匹配引用, 如果这段代码放在 `match p` 的下面, 会发生 move 错误
    match &p {
        pp @ &Point {x, y, z} => println!("{:?} {} {} {}", pp, x, y, z),
        _ => println!("{:?}", "other")
    }

    // 匹配结构体, 消费了 p
    match p {
       pp @ Point {x, y, z} => println!("{:?} {} {} {}", pp, x, y, z),
        _ => println!("{:?}", "other")
    }

    let value = Some(7);
    match value {
        Some(p  @ (2 | 3 | 5 | 7)) => println!("{p} is a prime"),
        Some(sq @ (0 | 1 | 4 | 9)) => println!("{sq} is a square"),
        None => println!("nothing"),
        Some(n) => println!("{n} is something else"),
    }

    // if-let
    let some_value = 3;
    if let 1 | 2 | 3 = some_value {
        println!("yep");
    }
}
