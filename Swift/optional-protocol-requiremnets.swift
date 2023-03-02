// You can define optional requiremnets for protocols. These requirements don't have to be implmented by types that conform to the protocol
// Optional requirements are prefixed by the optional modifier as part of the protocol's definition
// Optional requirements are avaiable so that you can write code that interoperates with Objective-C

    @objc protocol CounterDataSource {
        @objc optional func increment(forCount count: Int) -> Int
        @objc optional var fixedIncrement: Int { get }
    }


    class Counter {
        var count = 0
        var dataSource: CounterDataSource?
        func increment() {
            if let amount = dataSource?.increment?(forCount: count) {
                count += amount
            } else if let amount = dataSource?.fixedIncrement {
                count += amount
            }
        }
    }

    class ThreeSource: NSObject, CounterDataSource {
        let fixedIncrement = 3
    }

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
