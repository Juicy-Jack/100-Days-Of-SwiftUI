import Cocoa

//1 How to provide default values for parameters
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

//2 How to handle errors in functions
enum PasswordError: Error {
    case short, obvious
}
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    if password == "12345"{
        throw PasswordError.obvious
    }
    if password.count < 8 {
        return "OK"
    }
    if password.count < 10 {
        return"Good"
    } else {
        return"Excellent"
    }
}

let string = "abc"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}
//Checkpoint 4
enum numErr: Error {
    case outOfBounds, noRoot
}

func root(num: Int) throws -> Int {
    if num < 1 || num > 10000 {
        throw numErr.outOfBounds
    }
    
    for i in 1...num {
        if i * i == num {
            return i
        }
    }
    
    throw numErr.noRoot
}

do {
    let result = try root(num: 3)
    print(result)
} catch numErr.outOfBounds {
    print("Your input is out of bounds, enter a number between 1 to 10000.")
} catch numErr.noRoot {
    print("Your number does not have integer square root.")
}
