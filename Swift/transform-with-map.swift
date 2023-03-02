import _StringProcessing
import RegexBuilder

class StationData {
  var name: String
  var country: String
  var data: Array<Float>

  init?(name: String, country: String, data: Array<Float>) {
    if name.isEmpty  || country.isEmpty || data.isEmpty { return nil }
    self.name    = name
    self.country = country
    self.data    = data
  }
}

// 匹配单个 key=value 键值对儿
let keyval = Regex {
  OneOrMore(.any, .reluctant)
  "="
  OneOrMore(.whitespace)
  OneOrMore(.any)
  ZeroOrMore(.whitespace)
}

// 匹配多个键值对儿
let keyvalPattern = Regex {
  OneOrMore { keyval }
  ZeroOrMore(.whitespace)
}

// 匹配温度值
let temp = Regex {
  Optionally { "-" }
  OneOrMore(.digit)
  "."
  OneOrMore(.digit)
}

// 匹配某一年的观测值

let year = Regex { OneOrMore(.digit) }
let observation = Regex {
  Capture(as: year) { year }
  OneOrMore {
    Regex {
      OneOrMore(.whitespace)
      Capture { temp }
    }
  }
  ZeroOrMore(.whitespace)
}

// 匹配整个观测
let observations = Regex {
  Capture { keyvalPattern }  
  "Obs:"
  ZeroOrMore(.whitespace)
  TryCapture { 
    OneOrMore { observation }
  } transform: {
    StationData(name: "Test", country: "China", data: [1.0, 2.0, 3.0])
  }
}

// 某气象站的气象数据
let input = """
Name= Jan Mayen
Country= NORWAY
Lat=   70.9
Long=    8.7
Height= 10
Start year= 1921
End year= 2009
Obs:
1921 -4.4 -7.1 -6.8 -4.3 -0.8  2.2  4.7  5.8  2.7 -2.0 -2.1 -4.0
1922 -0.9 -1.7 -6.2 -3.7 -1.6  2.9  4.8  6.3  2.7 -0.2 -3.8 -2.6
2008 -2.8 -2.7 -4.6 -1.8  1.1  3.3  6.1  6.9  5.8  1.2 -3.5 -0.8
2009 -2.3 -5.3 -3.2 -1.6  2.0  2.9  6.7  7.2  3.8  0.6 -0.3 -1.3
"""

for match in input.matches(of: observations) {
  let (_, kv_pair, obs) = match.output
  print(kv_pair, obs)
}

// Name 观测员
// Country 国家
// Lat 纬度
// Long 经度
// Height 海拔高度
// Start Year 开始年份
// End year 结束年份
// Obs 观测结果

// 想得到的结果是一个字典、结构体或类
let stationDict: [String : Any] = [
  "Name": "Jan Mayen", 
  "Country": "NORWAY",
  "data": [
    [-4.4, -7.1, -6.8, -4.3, -0.8,  2.2,  4.7,  5.8,  2.7, -2.0, -2.1, -4.0],
    [-0.9, -1.7, -6.2, -3.7, -1.6,  2.9,  4.8,  6.3,  2.7, -0.2, -3.8, -2.6],
    [-2.8, -2.7, -4.6, -1.8,  1.1,  3.3,  6.1,  6.9,  5.8,  1.2, -3.5, -0.8],
    [-2.3, -5.3, -3.2, -1.6,  2.0,  2.9,  6.7,  7.2,  3.8,  0.6, -0.3, -1.3]
  ]
]