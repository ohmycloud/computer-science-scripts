use std::path::{PathBuf, Path};

fn main() {
    let mut path = PathBuf::new();
    path.push(r"D:\");
    path.push(r"scripts");
    path.push(r"Rust");
    path.push(r"path_buf");
    path.push(r"Cargo");
    path.set_extension("toml");
    
    println!("{:?}", path);

    let path: PathBuf = [r"D:\", r"scripts", r"Rust", r"path_buf", r"Cargo.toml" ].iter().collect();
    println!("{:?}", path);

    let path = PathBuf::from(r"D:\scripts\Rust\path_buf\Cargo.toml");
    println!("{:?}", path);

    let p = Path::new(r"D:\scripts\Rust\path_buf\Cargo.toml");
    assert_eq!(path.as_path(), p);

    let mut path = PathBuf::from("/tmp");
    path.push("/etc");
    assert_eq!(path, PathBuf::from("/etc"));

    let mut p = PathBuf::from("/spirited/away.rs");
    p.pop();

    assert_eq!(Path::new("/spirited"), p);

    p.pop();
    assert_eq!(Path::new("/"), p);
}
