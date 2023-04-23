use std::mem;

fn main() {
    let story = String::from("Once upon a time...");

    let mut story = mem::ManuallyDrop::new(story);
    
    let ptr = story.as_mut_ptr();
    let len = story.len();
    let capacity = story.capacity();
    
    assert_eq!(19, len);
    println!("{:?}", capacity);


    let s = unsafe { String::from_raw_parts(ptr, len, capacity) };
    assert_eq!(String::from("Once upon a time..."), s);


    let mut z = String::with_capacity(25);
    println!("{}", z.capacity());

    for _ in 0..5 {
        z.push_str("hello");
        println!("{}", z.capacity());
    }

    let sparkle_heart = vec![240, 159, 146, 150];
    let sparkle_heart = String::from_utf8(sparkle_heart).unwrap();
    println!("{:?}", sparkle_heart);

    let sparkle_heart = vec![240, 159, 146, 150];
    let sparkle_heart = String::from_utf8_lossy(&sparkle_heart);
    println!("{:?}", sparkle_heart);


    // some invalid bytes
    let input = b"Hello \xF0\x90\x80World";
    let output = String::from_utf8_lossy(input);

    assert_eq!("Hello �World", output);
    println!("{:?}", output);


    // 𝄞music
    let v = &[0xD834, 0xDD1E, 0x006d, 0x0075,
              0x0073, 0x0069, 0x0063];
    let music = String::from_utf16(v).unwrap();
    assert_eq!(String::from("𝄞music"), music);
    println!("{:?}", music);
}
