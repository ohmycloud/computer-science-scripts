    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }


    let arr = [-7, 6, 77, 5, -9, 5, 3]
    let res = minMax(array: arr)
    print("min is \(res.min) and max is \(res.max)")
