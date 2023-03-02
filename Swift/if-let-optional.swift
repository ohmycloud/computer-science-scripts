let vegetable = "cucumber"

switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasPrefix("red"):
    print("Oppsss, Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}
