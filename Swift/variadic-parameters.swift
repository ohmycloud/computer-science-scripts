func arithmeticMean(_ numbers: Double..., times of: Int, _ names: String...) -> String {
    var sum = 0.0
    for i in numbers {
      sum += i
    }
    var strings = " "
    for i in names {
       strings += (i + " ")
    }
    return String(sum * Double(of)) + " " + strings 
}

print(arithmeticMean(1,2,3,4,5,6,7, times: 100, "Raku", "MoarVM", "Ziglang"))

