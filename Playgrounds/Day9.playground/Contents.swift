import Cocoa

//1 How to create and use closures
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let captainFirstTeam1 = team.sorted(by: {
    (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
})

print(captainFirstTeam1)

//2 How to use trailing closures and shorthand syntax
let captainFirstTeam2 = team.sorted {
    if $0 == "Suzanne"{
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    return $0 < $1
}

print(captainFirstTeam2)

let reverseTeam = team.sorted {$0 > $1}
print(reverseTeam)

let tOnly = team.filter {$0.hasPrefix("T")}
print(tOnly)

let upperCaseTeam = team.map {$0.uppercased()}
print(upperCaseTeam)

//3 How to accept functions as parameters
func generateNumber() -> Int{
    return Int.random(in: 1...20)
}

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    return numbers
}

let arr1 = makeArray(size: 50, using: generateNumber)
print(arr1)

let arr2 = makeArray(size: 50) {
    Int.random(in: 1...20)
}
print(arr2)

/* Checkpoint 5
 Your input is this: let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
 Your job is:
 filter out any numbers that are even, sort the array in ascending order, map them to
 strings in the format "7 is a lucky number", print the resulting array, one item per line. */

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let a1 = luckyNumbers.filter {!($0.isMultiple(of: 2))}.sorted().map {"\($0) is a lucky number"}
let size = a1.count

for i in 0..<size {
    print(a1[i])
}
