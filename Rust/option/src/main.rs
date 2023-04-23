fn main() {
    // let v = vec![1,2,3,4,5];
    // if let Some(d) = v.get(3) {
    //     println!("{}", d);
    // }
    // println!("{:?}", v.get(3));

    // let f = ["apple", "orange", "banana"];
    // for &idx in [0,1,2,99].iter() {
    //     match f.get(idx) {
    //         Some(&"banana") => println!("椰子很美味"),
    //         Some(fruit) => println!("{:?} is decious!", fruit),
    //         None => println!("Not a fruit")
    //     }
    //     println!("{:?}", idx);
    // }

    let gift: Option<&str> = None;//Some("candy");
    // assert_eq!(gift.unwrap(), "candy");
    // gift.expect("水果卖光了");

    let a = Some("value");
    assert_eq!(a.expect("fruits are healthy"), "value");

    // unwrap_or
    println!("{:?}", gift.unwrap_or("明天早点来"));
    println!("{:?}", Some("energy").unwrap_or("charge"));
}
