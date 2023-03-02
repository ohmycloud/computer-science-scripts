var shoppingList = ["Eggs", "Milk"]
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

print(shoppingList)

shoppingList[4...6] = ["Bananas", "Apples"]

print(shoppingList)

shoppingList.insert("Maple Syrup", at: 0)
shoppingList.insert("end", at: shoppingList.endIndex)
let egg = shoppingList.remove(at: 0)
print(shoppingList)
print(egg)
