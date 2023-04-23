use std::borrow::Borrow;
use std::fmt::Debug;
use std::borrow::Cow;
use std::hash::Hasher;
use std::collections::hash_map::DefaultHasher;
use std::hash::Hash;
use std::any::type_name;

fn main() {
    /*
    let s: String = "Perl".to_string();

    check(s);
    
    let s = "Perl";
    
    check(s);

    let a= Cow::Borrowed("Rakudo");
    println!("{:?}", a);
    let string = String::from("Rakudo Star");
    let a = Cow::Borrowed(&string);
    println!("{:?}", a);
    */
    let str = "Rakudo Star";
    let cleaned = clean(str, 10);
    println!("{:?}", cleaned);
    println!("{:?}", type_of(cleaned));


    let cleaned = clean(str, 22);
    println!("{:?}", cleaned);
    println!("{:?}", type_of(cleaned));
}

fn type_of<T>(_: T) -> &'static str {
    type_name::<T>()
}

fn clean(s: &str, len: u32) -> Cow<str> {
    if len > 17 {
        let cleaned: String = s.chars().filter(|x| *x != 'a').collect();
        Cow::Owned(cleaned)
    } else {
        Cow::Borrowed(s)
    }
}

fn check<T: Borrow<str> + Debug>(s: T) {
    println!("{:?}", s);
    assert_eq!("Perl", s.borrow());
}



fn get_hash<T: Hash>(t: T) -> u64 {
    let mut hasher = DefaultHasher::new();
    t.hash(&mut hasher);
    hasher.finish()
}

fn asref_example<Owned, Ref>(owned1: Owned, owned2: Owned)
where
    Owned: Eq + Ord + Hash + AsRef<Ref>,
    Ref: Eq + Ord + Hash
{
    let ref1: &Ref = owned1.as_ref();
    let ref2: &Ref = owned2.as_ref();
    
    // refs aren't required to be equal if owned types are equal
    assert_eq!(owned1 == owned2, ref1 == ref2); // ❌
    
    let owned1_hash = get_hash(&owned1);
    let owned2_hash = get_hash(&owned2);
    let ref1_hash = get_hash(&ref1);
    let ref2_hash = get_hash(&ref2);
    
    // ref hashes aren't required to be equal if owned type hashes are equal
    assert_eq!(owned1_hash == owned2_hash, ref1_hash == ref2_hash); // ❌
    
    // ref comparisons aren't required to match owned type comparisons
    assert_eq!(owned1.cmp(&owned2), ref1.cmp(&ref2)); // ❌
}

fn borrow_example<Owned, Borrowed>(owned1: Owned, owned2: Owned)
where
    Owned: Eq + Ord + Hash + Borrow<Borrowed>,
    Borrowed: Eq + Ord + Hash
{
    let borrow1: &Borrowed = owned1.borrow();
    let borrow2: &Borrowed = owned2.borrow();
    
    // borrows are required to be equal if owned types are equal
    assert_eq!(owned1 == owned2, borrow1 == borrow2); // ✅
    
    let owned1_hash = get_hash(&owned1);
    let owned2_hash = get_hash(&owned2);
    let borrow1_hash = get_hash(&borrow1);
    let borrow2_hash = get_hash(&borrow2);
    
    // borrow hashes are required to be equal if owned type hashes are equal
    assert_eq!(owned1_hash == owned2_hash, borrow1_hash == borrow2_hash); // ✅
    
    // borrow comparisons are required to match owned type comparisons
    assert_eq!(owned1.cmp(&owned2), borrow1.cmp(&borrow2)); // ✅
}