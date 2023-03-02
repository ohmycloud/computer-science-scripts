// Adding constraints to an Associated Type    
protocol Container {
        associatedtype Item: Equatable
        mutating func append(_ item: Item)
        var count: Int { get }
        subscript(i: Int) -> Item { get }
    }


extension Array: Container {}
let a = [1,2,3,4,5]
print(a[3])
