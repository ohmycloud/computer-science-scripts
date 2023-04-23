extern crate console;

use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};
use std::thread;
use std::time::Duration;
use console::{style, Term};

fn main() {
    // write_chars();
    do_stuff().unwrap();
}

fn read_line_by_line() {
    let f = File::open(r"D:\scripts\conn-mysql.raku").expect("Unable to open file");
    let f = BufReader::new(f);

    for line in f.lines() {
        let line = line.expect("Unable to read line");
        println!("Line: {}", line);
        thread::sleep(Duration::from_millis(2000));
    }
}

fn write_chars() -> std::io::Result<()> {
    let term = Term::stdout();
    let (heigth, width) = term.size();
    for x in 0..width {
        for y in 0..heigth {
            term.move_cursor_to(x as usize, y as usize)?;
            let text = if (x + y) % 2 == 0 {
                format!("{}", style(x % 10).black().on_red())
            } else {
                format!("{}", style(x % 10).red().on_black())
            };

            term.write_str(&text)?;
            thread::sleep(Duration::from_micros(60));
        }
    }
    Ok(())
}

fn do_stuff() -> io::Result<()> {
    let term = Term::stdout();
    term.set_title("Counting...");
    term.write_line("Going to do some counting now")?;
    term.hide_cursor()?;
    for x in 0..10 {
        if x != 0 {
            term.move_cursor_up(1)?;
        }
        term.write_line(&format!("Counting {}/10", style(x + 1).cyan()))?;
        thread::sleep(Duration::from_millis(400));
    }
    term.show_cursor()?;
    term.clear_last_lines(1)?;
    term.write_line("Done counting!")?;
    writeln!(&term, "Hello World!")?;

    write!(&term, "To edit: ")?;
    let res = term.read_line_initial_text("default")?;
    writeln!(&term, "\n{}", res)?;

    Ok(())
}