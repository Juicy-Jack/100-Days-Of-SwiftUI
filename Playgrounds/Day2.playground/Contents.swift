import Cocoa

//1 How to store truth with Booleans
var gameOver = false
print(gameOver)
gameOver.toggle()
print(gameOver)

//2 How to join strings together
let firstPart = "Hello, "
let secondPart = "world!"
let greeting = firstPart + secondPart
print(greeting)

let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old"
print(message)

// Checkpoint 1
// Creat a program for converting any given temperature in celsius to fahrenheit
let cels = 30
let fahr = (cels * 9 / 5) + 32
print("Temperature in Celsius = \(cels)\nTemperature in Fahrenheit = \(fahr)")
