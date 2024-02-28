import Cocoa

//1 How to store ordered data in arrays
var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 26, 43]
var temperatures = [25.3, 38.5, 12.3]

print(beatles[0])
print(numbers[3])
print(temperatures[2])

beatles.append("Allen")
print(beatles[4])

var scores = Array<Int>()
scores.append(13)
scores.append(44)
print(scores[1])

var albums = [String]()
albums.append("Folklore")

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.remove(at: 2)
print(characters.count)
characters.removeAll()
print(characters.count)

let bondMovies = ["Casino Royale", "Spectre", "No Time To Die"]
print(bondMovies.contains("Frozen"))
let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())

//How to store and find data in dictionaries

let olympics = [
    2012: "London",
    2016: "Rio de Jeneiro",
    2021: "Tokyo"
]

print(olympics[2012, default: "Unknown"])
print(olympics[2008, default: "Unknown"])

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206
print(heights["LeBron James", default: 0])

//3 How to use sets for fast data lookup

let people1 = Set(["Denzel Washington", "Tom Cruise", "Samuel L Jackson"])
print(people1)

var people2 = Set<String>()
people2.insert("Denzel Washington")
people2.insert("Tom Cruise")
people2.insert("Nicolas Cage")
people2.insert("Samuel L Jackson")
print(people2)

//4 How to create and use enums
enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
}

var day = Weekday.monday
day = .tuesday
day = .friday

