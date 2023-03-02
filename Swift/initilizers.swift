class Food {
  var name: String
  init(name: String) {
    self.name = name
  }
  convenience init() {
    self.init(name: "Unnamed")
  }
}

// The init(name: String) initializer from the Food class is provided as a designated initializer,
//    because it ensures that all stored properties of a new Food instance are fully initialized.
// The Food class doesn’t have a superclass,
//    and so the init(name: String) initializer doesn’t need to call super.init() to complete its initialization.
let namedMeat = Food(name: "Bacon")
print(namedMeat.name)

class RecipeIngredient: Food {
  var quantity: Int
  init(name: String, quantity: Int) {
    self.quantity = quantity
    super.init(name: name)
  }
  override convenience init(name: String) {
    self.init(name: name, quantity: 1)
  }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
