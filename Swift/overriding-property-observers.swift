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
   
   class AutomaticCar: Car {
     override var currentSpeed: Double {
       didSet {
         gear = Int(currentSpeed / 10.0) + 1
         print("gear is now \(gear)")
       }
     }
   }

   let car = Car()
   car.currentSpeed = 20
   car.gear = 5
   print(car.description)
   car.makeNoise()

   let automaticCar = AutomaticCar()
   automaticCar.currentSpeed = 20
   print(automaticCar.gear)
