import Cocoa


//1 How to create your own structs
struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()

struct Employee1 {
    let name: String
    var vacationRemaining: Int
    
    mutating func takeVacation(days: Int) { //We use mutating when our func make changes on variables in our struct. In this case this func modifying vacationRemaining var.
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enoygh days remaining.")
        }
    }
}


var archer1 = Employee1(name: "Sterling Archer", vacationRemaining: 14)// In order to use the function in our struct, we need to assign it on a var not a let
archer1.takeVacation(days: 5)
print(archer1.vacationRemaining)

//2 How to compute property values dynamically
struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer2 = Employee2(name: "Sterling Archer", vacationAllocated: 14)
archer2.vacationTaken += 4
archer2.vacationRemaining = 5
print(archer2.vacationAllocated)

//3 How to take action when a propety changes
struct App {
    var contacts = [String]() {
        willSet {// willSet execute the code before modification
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }
        didSet {// didSet execute the code after the modification
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Furkido")
app.contacts.append("Alico")
app.contacts.append("Miro")

//4 How to create custom initializers
struct Player {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}
let player = Player(name: "Furki")
print(player.number)
