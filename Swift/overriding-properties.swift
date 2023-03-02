// 覆盖 getters 和 setters
    class Vehicle {
        var currentSpeed = 0.0
        var description: String {
            return "traveling at \(currentSpeed) miles per hour"
        }
        func makeNoise() {
            // do nothing - an arbitrary vehicle doesn't necessarily make a noise
        }
    }

   class Car: Vehicle {
     var gear = 1
     override var description: String {
       return super.description + " in gear \(gear)"
     }
     override func makeNoise() {
       print("make Noise")
     }
   }

   let car = Car()
   car.currentSpeed = 2
   car.gear = 5
   print(car.description)
   car.makeNoise()
