
// Protocol
protocol Fruit {
    func getPrice() -> String
    func getCount() -> Int
}

// Implements Fruit Protocol
class Orange: Fruit {
    func getPrice() -> String {
        return "$5"
    }
    func getCount() -> Int {
        return 2
    }
}

// Implements Fruit Protocol
class Banana: Fruit {
    func getPrice() -> String {
        return "$2"
    }
    
    func getCount() -> Int {
        return 5
    }
}

// Implements Fruit Protocol
class Grapes: Fruit {
    func getPrice() -> String {
        return "$3.5"
    }
    
    func getCount() -> Int {
        return 1
    }
}

// Fruit type enum
enum FruitType {
    case orange, banana, grapes
}

// factory class with a static method
class FruitFactory {
    // Returns the object ofthe class that implemnets Fruit protocol
    static func getFruit(forType type: FruitType) -> Fruit? {
        switch type {
        case .orange:
            return Orange()
        case .banana:
            return Banana()
        case .grapes:
            return Grapes()
        }
    }
}


// get the object of class Orange from the FruitFactory class
let orange = FruitFactory.getFruit(forType: .orange)
orange?.getPrice() // "$5
orange?.getCount() // 2
// get the object of class Grapes from the FruitFactory class
let grapes = FruitFactory.getFruit(forType: .grapes)
grapes?.getPrice() // "$3"
grapes?.getCount() // 1
