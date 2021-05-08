#!/usr/bin/swift

import Foundation

let S1 = -1.66666666666666324348e-01;  // -1/(3!)
let S2 = 8.3333333332248946124e-03;    //  1/(5!)
let S3 = -1.98412698298579493134e-04;  // -1/(7!)
let S4 = 2.75573137070700676789e-06;   //  1/(9!)
let S5 = -2.50507602534068634195e-08;  // -1/(11!)
let S6 = 1.58969099521155010221e-10;   //  1/(13!)

func usersin(_ xOrig: Double) -> Double {
    // Reduce x to be between 0 and 2pi
    var x = xOrig.truncatingRemainder(dividingBy: 2 * Double.pi)
    
    // If it's between pi/2 => pi or 3pi/2 => 2pi. Flip it horizontally
    if (x > Double.pi/2 && x < Double.pi) || (x > (3*Double.pi)/2 && x < 2*Double.pi) {
        x = x - (Double.pi/2)
    }
    
    let z = x*x                          // x^2
    let v = z*x                          // x^3
    let r = S2+z*(S3+z*(S4+z*(S5+z*S6))) // Taylor function part 1/2
    
    // Flip the function if needed, eg between pi and 2pi
    if x > Double.pi && x < Double.pi * 2 {
        return -x+v*(S1+z*r)             // Taylor function part 2/2 (but negative)
    } else {
        // No need for vertical flip
        return x+v*(S1+z*r)             // Taylor function part 2/2
    }
}

func printTimeElapsedWhenRunning(title: String, operation: (() -> Void)) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Time elapsed for \(title): \(timeElapsed) s.")
}

printTimeElapsedWhenRunning(title: "User Sin") {
    for i in 0..<1000000 {
        let _ = usersin(Double(i))
    }
}

printTimeElapsedWhenRunning(title: "Normal Sin") {
    for i in 0..<1000000 {
        let _ = sin(Double(i))
    }
}
