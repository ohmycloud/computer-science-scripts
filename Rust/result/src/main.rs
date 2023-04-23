#[derive(Debug)]
struct DivisionZeroErr;

type Division<f64, DivisionZeroErr> = Result<f64, DivisionZeroErr>;

fn safe_division(numerator: f64,  denominator: f64) -> Division<f64, DivisionZeroErr> {
    if denominator == 0.0 {
        Err(DivisionZeroErr)
    } else {
        Ok(numerator / denominator)
    }
}

fn main() {
    println!("{:?}", safe_division(1.0, 2.0));
    println!("{:?}", safe_division(2.0, 4.0));
    println!("{:?}", safe_division(1.0, 0.0));
}
