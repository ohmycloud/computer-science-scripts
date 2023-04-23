use fluent_uri::Uri;
use std::collections::HashMap;
use fluent_uri::EStr;

fn main() {
    let s = "name=%E5%BC%A0%E4%B8%89&speech=%C2%A1Ol%C3%A9%21";
    let map: HashMap<_, _> = EStr::new(s)
        .split('&')
        .filter_map(|s| s.split_once('='))
        .map(|(k, v)| (k.decode(), v.decode()))
        .filter_map(|(k, v)| k.into_string().ok().zip(v.into_string().ok()))
        .collect();
assert_eq!(map["name"], "张三");
assert_eq!(map["speech"], "¡Olé!");
}
