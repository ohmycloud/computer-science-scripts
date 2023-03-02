// Property observers observe and respond to changes in a property’s value. 
// Property observers are called every time a property’s value is set, 
//   even if the new value is the same as the property’s current value.

// 添加属性观察者的地方
// 1. 你定义的存储属性
// 2. 你继承的存储属性
// 3. 你继承的计算属性

class StepCounter {
  var totalSteps: Int = 0 {
    /*
    willSet(newTotalSteps) {
      print("About to set totalSteps to \(newTotalSteps)")
    }
    */
    willSet {
      print("About to set totalSteps to \(newValue)")
    }

    didSet {
      if totalSteps > oldValue {
        print("oldValue is \(oldValue). Added \(totalSteps - oldValue) steps")
      } else {
        print("\(oldValue - totalSteps) backward")
      }
    }
  }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 120

stepCounter.totalSteps = 896
