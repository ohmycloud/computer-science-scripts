use regex::Regex;

mod authentication;

fn main() {
    let mut user = authentication::User::new("jeremy", "super-secret");

    println!("The username is: {}", user.get_username());
    user.set_password("even-more-secret");
    println!("{:?}", user.get_passwd());

    // create a regex obj
    let re = Regex::new(r"^\d{4}-\d{2}-\d{2}$").unwrap();
    let bool_match = re.is_match("2020-09-36");
    println!("{:?}", bool_match);
}
