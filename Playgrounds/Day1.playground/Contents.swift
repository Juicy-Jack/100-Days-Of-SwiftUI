import Cocoa

//1 How to create variables and constants
var name = "Ted"
name = "Rebecca"
name = "Keeley"

let character = "Dephne"//use let to assign constant value

var playerName = "Roy"
print(playerName)
playerName = "Dani"
print(playerName)
playerName = "Sam"
print(playerName)

//2 How to create strings
let movie = """
A day in
the life of an
Apple engineer
"""//use three sets of quotes to create strings across multiple lines
print(movie.count)
print(movie.uppercased())

//3 How to stroe whole numbers
let number1 = 120
print(number1.isMultiple(of: 3))

//4 How to store  decimal numbers
let number2 = 0.1 + 0.2
print(number2)
