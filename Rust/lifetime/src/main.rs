
#![allow(unused)]
fn main() {
    // let mut data = vec![1, 2, 3];
    // data.push(4);
    // let x = &data[0];
    // println!("{}", x);

    // to_owned("abcd");
    // lifetime_a();
    // drop_at_tne_end_of_scope();
    let input = "hello world";
    test(
        Test { test: input }
    );
}


fn bar(x: &mut i32) {}
fn foo(a: &mut i32) {
    bar(a); // error: cannot borrow `*a` as mutable because `a` is also borrowed
            //        as immutable
    let y = &a; // a is borrowed as immutable.        
    println!("{}", y);
}

fn to_owned(str: &str) -> String {
    let v = &[1,2,3];
    let vv = v.to_owned();
    println!("{:?}", vv);
    str.to_owned()
}

fn lifetime_a() -> () {
    let mut data = vec![1, 2, 3];
    let x = &data[0];
    println!("{}", x);
    // This is OK, x is no longer needed
    data.push(4);
}

#[derive(Debug)]
struct X<'a>(&'a i32);

impl<'a> Drop for X<'a> {
    fn drop(&mut self) { println!("{:?}", self) }
}

fn drop_at_tne_end_of_scope() -> () {
    let mut data = vec![1, 2, 3];
    let x = X(&data[0]);
    println!("{:?}", x);
    // data.push(4);
    // Here, the destructor is run and therefore this'll fail to compile.
}

struct Test<'a> {
    test: &'a str // a string slice, any instances of this struct may have MUST live as long as `a` does
}

fn test<'a>(input: Test<'a>) {
    println!("{}", input.test);
}