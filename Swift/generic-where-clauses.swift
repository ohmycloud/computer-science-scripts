// A generic where clause enables you to require that an associated type must conform to a certain protocol
//   or that certain type parameters and associated types must be the same
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherCOntainer: C2) -> Bool
  where C1.Item == C2.Item, C1.Item: Equatable {
    // 
    if someContainer.count != anotherCOntainer.count {
      return false
    }

    for i in 0..<someContainer.count {
      if someContainer[i] != anotherCOntainer[i] { return false }
    }
    return true
  }
