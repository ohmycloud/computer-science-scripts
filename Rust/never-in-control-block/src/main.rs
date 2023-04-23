fn main() {
    let mut a = 5;
    let b = loop {
        a *= 5;
        if a > 10000 {
            break;
        }
    };
    println!("a = {:?}, b = {:?}", a, b);

    let mut counter = 0;
    while counter < 10 {
        counter += 1;
        println!("{:?}", counter);
    }

    println!("\n");

    let a = [10, 20, 30, 40, 50];
    for e in a.iter() {
        println!("{:?}", e);
    }

    for i in 1..=5 {
        println!("i = {}", i);
    }
}
