import Cocoa

func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

showWelcome()

//2 How to return values from functions
func rollDice() -> Int {
    return Int.random(in: 1...6)
}
let result = rollDice()
print(result)

func areLettersIdentical(string1: String, string2: String) -> Bool {
    return string1.sorted() == string2.sorted()
}
print(areLettersIdentical(string1: "selam", string2: "males"))

func pythagaros(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}//when we have one line of code we need not to use return keyword
let c = pythagaros(a: 3, b: 4)
print(c)

//3 How to return multiple values from functions
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}
let (firstName, lastName) = getUser()
print("Name: \(firstName) \(lastName)")

//4 How to customize parameter labels
func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) i \(i * number)")
    }
}
printTimesTables(for: 5)
