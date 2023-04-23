fn main() {
    println!("Hello, world!");
}

fn add(a: f64, b: f64) -> f64 {
    a + b
}

fn sub(a: u32, b: u32) -> u32 {
    a - b
}

#[test]
fn add_works() {
    assert_eq!(add(1.0, 2.0), 3.0);
    assert_eq!(add(7.0, 2.0), 9.0);
    assert_eq!(add(4.8, 5.2), 10.0);
}

#[test]
fn sub_works() {
    assert_eq!(sub(13_u32, 4_u32), 9_u32);
    assert_eq!(sub(7_u32, 1_u32), 6_u32);
    assert_eq!(sub(17_u32, 4_u32), 13_u32);
}

#[test]
#[ignore = "not yet reviewed by the Q.A"]
fn sub_fails() {
    assert_eq!(sub(17_u32, 14_u32), 3_u32);
}