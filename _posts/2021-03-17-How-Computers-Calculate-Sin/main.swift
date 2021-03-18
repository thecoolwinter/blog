#!/usr/bin/swift

import Foundation

let S1 = -1.66666666666666324348e-01;  // -1/(3!)
let S2 = 8.3333333332248946124e-03;    //  1/(5!)
let S3 = -1.98412698298579493134e-04;  // -1/(7!)
let S4 = 2.75573137070700676789e-06;   //  1/(9!)
let S5 = -2.50507602534068634195e-08;  // -1/(11!)
let S6 = 1.58969099521155010221e-10;   //  1/(13!)

func usersin(_ x: Double) -> Double {
  let z = x*x                          // x^2
  let v = z*x                          // x^3
  let r = S2+z*(S3+z*(S4+z*(S5+z*S6))) // Taylor function part 1/2
  return x+v*(S1+z*r)                   // Taylor function part 2/2
}

print("Pi/6")
print("usersin:\t\(usersin(Double.pi/6))")
print("sin:\t\t\(sin(Double.pi/6))")
print("\nPi/8")
print("usersin:\t\(usersin(Double.pi/8))")
print("sin:\t\t\(sin(Double.pi/8))")
print("\nPi/21")
print("usersin:\t\(usersin(Double.pi/21))")
print("sin:\t\t\(sin(Double.pi/21))")
