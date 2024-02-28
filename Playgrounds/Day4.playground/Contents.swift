import Cocoa

//1 How to use type annotations

let playerName: String = "Roy"
var luckyNumber: Int = 13
let pi: Double = 3.141
var albums: [String] = ["Red", "Fearless"]
var user: [String:String] = ["id": "@juicyjack"]
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, Other"])

//Checkpoint 2
//This time the challenge is to create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array.

let arr = ["The Story of Art", "Nutuk", "Boyle Buyurdu Zerdust", "1984", "1984", "Refah Devletinden Sonra"]
var size = arr.count
let set1 = Set(arr)
var numUni = set1.count
print("Number of items in array = \(size)")
print("Number of unique items in array = \(numUni)")
