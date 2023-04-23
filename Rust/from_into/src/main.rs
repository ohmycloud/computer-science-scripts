use std::{collections::LinkedList,  string::ParseError, num::ParseIntError};

fn main() {
  let vec = vec![5, 4, 1u8, 2, 3];
  // Convert a slice
  let sorted = SortedVec::from(&vec[1..]);
  println!("{:?}", sorted);

  // Convert a vector
  let sorted = SortedVec::from(vec);
  println!("{:?}", sorted);

  // Convert a linked list
  let mut linklist: LinkedList<u8> = LinkedList::new();
  linklist.extend(&[15,6,8,9]);
  let sorted = SortedVec::from(linklist);
  println!("{:?}", sorted);

  println!("{:?}", u8::from(PacketType::Fin));

  let num = 10u16;
  println!("{:?}", times_ten(num));
}

#[derive(Debug)]
struct SortedVec<T>(Vec<T>);

// 把 slice 转换成 SortedVec
impl<'a, T: Ord + Clone> From<&'a [T]> for SortedVec<T> {
  fn from(slice: &[T]) -> Self {
      let mut vec = slice.to_owned();
      vec.sort();
      SortedVec(vec)
  }
}

impl <T: Ord + Clone> From<Vec<T>> for SortedVec<T> {
    fn from(mut vec: Vec<T>) -> Self {
        vec.sort();
        SortedVec(vec)
    }
}

impl<T: Ord + Clone> From<LinkedList<T>> for SortedVec<T> {
    fn from(list: LinkedList<T>) -> Self {
        let mut vec: Vec<T> = list.iter().cloned().collect();
        vec.sort();
        SortedVec(vec)
    }
}

#[derive(Debug)]
enum PacketType {
    Data,
    Fin,
    State,
    Reset,
    Syn,
}

impl From<PacketType> for u8 {
    fn from(origin: PacketType) -> u8 {
        match origin {
            PacketType::Data => 0,
            PacketType::Fin => 1,
            PacketType::Reset => 2,
            PacketType::State => 3,
            PacketType::Syn => 4,
        }
    }
}


// impl TryFrom<u8> for PacketType {
//     type Error = ParseIntError;
//     fn try_from(origin: u8) -> Result<Self, Self::Error> {
//         match origin {
//             0 => Ok(PacketType::Data),
//             1 => Ok(PacketType::Fin),
//             2 => Ok(PacketType::Reset),
//             3 => Ok(PacketType::State),
//             4 => Ok(PacketType::Syn),
//             n => Err(ParseIntError(IntErrorKind))
//         }
//     }
// }

fn times_ten<T: Into<f32>>(value: T) -> f32 {
    value.into() * 10.0
}