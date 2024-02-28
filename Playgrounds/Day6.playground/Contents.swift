import Cocoa

//1 How to use a for loop to repeat work
let platforms = ["IOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os)")
}

for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}

for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
}

//2 How to use while loop to repeat work
var countdown = 10

while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}

print("Blast off!")

//Checkpoint 3
/*The problem is called fizz buzz, and has been used in job interviews, university entrance tests, and more for as long as I can remember. Your goal is to loop from 1 through 100, and for each number:

1. If it’s a multiple of 3, print “Fizz”
2. If it’s a multiple of 5, print “Buzz”
3. If it’s a multiple of 3 and 5, print “FizzBuzz”
4. Otherwise, just print the number.
*/

for counter in 1...100 {
    if counter.isMultiple(of: 15) {
        print("FizzBuzz")
    } else if counter.isMultiple(of: 5) {
        print("Buzz")
    } else if counter.isMultiple(of: 3) {
        print("Fizz")
    } else {
        print(counter)
    }
}
