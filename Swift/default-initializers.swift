class ShoppingListItem {
  var name: String?
  var quantity = 1
  var purchased = false
}

// The default initializer simply creates a new instance with all of its properties set to their default values.
let item = ShoppingListItem()

if let name = item.name {
  print(name)
}
