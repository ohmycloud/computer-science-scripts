use std::str::Split;

fn main() {
    let value = process2();

    println!("Ergebnis: {:?}", value);
}

/*
fn process<'a>() -> Vec<&'a str> {
    let testballon = Ok("testzztestztest");

    let string: String = match testballon {
        Ok(content) => content.to_string(),
        Err(err) => err,
    };


    let string = if string.contains("zz") {
        string.replace("zz", "n")
    } else {
        string.replace("z", "n")
    };

    let lines: Split<&str> = string.split("\n");

    let v: Vec<&str> = lines.collect();

    v
}
*/


fn process2() -> Vec<String> {
    let testballon = Ok("testzztestztest");

    let string = match testballon {
        Ok(content) => content.to_string(),
        Err(err) => err,
    };

    let string = if string.contains("zz") {
        string.replace("zz", "n")
    } else {
        string.replace("z", "n")
    };

    string.split("\n").map(|s| s.to_string()).collect()
}
