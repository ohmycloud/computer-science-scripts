fn main() {
    let items = vec![
        String::from("Rakudo"),
        String::from("Star"),
        String::from("MoarVM"),
    ];
    let mut mystruct = MyType { items };

    impl_trait_for_type_in_return_type(&mut mystruct);
    impl_triat_for_type(mystruct);
}

fn impl_trait_for_type_in_return_type(s: &mut MyType) {
    for i in s.iter() {
        println!("{:?}", i);
    }

    assert_eq!(s.next(), Some("MoarVM".to_string()));
    assert_eq!(s.next(), Some("Star".to_string()));
    assert_eq!(s.next(), Some("Rakudo".to_string()));
    assert_eq!(s.next(), None);
}

fn impl_triat_for_type(s: MyType) {
    for i in s {
        println!("{:?}", i);
    }
}

struct MyType {
    items: Vec<String>,
}

/// The other use of the impl keyword is in impl Trait syntax,
/// which can be seen as a shorthand for "a concrete type that implements this trait".
/// Its primary use is working with closures,
/// which have type definitions generated at compile time that can't be simply typed out.
impl MyType {
    fn iter(&self) -> impl Iterator<Item = &String> {
        self.items.iter()
    }
}

impl Iterator for MyType {
    type Item = String;

    fn next(&mut self) -> Option<Self::Item> {
        if self.items.is_empty() {
            None
        } else {
            Some(self.items.pop().unwrap())
        }
    }
}