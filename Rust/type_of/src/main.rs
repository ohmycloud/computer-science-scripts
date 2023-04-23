use std::any::type_name;

fn type_of<T>(_: T) -> &'static str {
    type_name::<T>()
}

fn main() {
    let x = 21;
    let y = 2.5;
    println!("{}", type_of(&y));
    println!("{}", type_of(x));
    println!("{}", type_of("abc"));
    println!("{}", type_of(String::from("abc")));
    println!("{}", type_of(vec![1, 2, 3]));
    println!("{}", type_of(main));
    //println!("{}", type_of(&type_of::));
}