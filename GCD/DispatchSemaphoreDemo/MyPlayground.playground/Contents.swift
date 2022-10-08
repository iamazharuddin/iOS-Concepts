import UIKit
protocol Banking {
    func withDrawAmount(amount: Double) throws;
}

enum WithdrawalError : Error {
    case inSufficientAccountBalance
}

var accountBalance = 30000.00
let semaphore = DispatchSemaphore(value: 1)

struct Atm : Banking {

    func withDrawAmount(amount: Double) throws {
        semaphore.wait()
        debugPrint("inside atm")
        guard accountBalance > amount else { throw WithdrawalError.inSufficientAccountBalance }
        // Intentional pause : ATM doing some calculation before it can dispense money
        Thread.sleep(forTimeInterval: Double.random(in: 1...3))
        accountBalance -= amount
        semaphore.signal()
    }

    func printMessage() {
        debugPrint("ATM withdrawal successful, new account balance = \(accountBalance)")
    }
}

struct Bank : Banking {

    func withDrawAmount(amount: Double) throws {
        semaphore.wait()
        debugPrint("inside bank")

        guard accountBalance > amount else { throw WithdrawalError.inSufficientAccountBalance }

        // Intentional pause : Bank person counting the money before handing it over
        Thread.sleep(forTimeInterval: Double.random(in: 1...3))
        accountBalance -= amount
        semaphore.signal()
    }

    func printMessage() {
        debugPrint("Bank withdrawal successful, new account balance = \(accountBalance)")
    }
}

//let queue = DispatchQueue(label: "semaphoreDemo", qos: .utility, attributes: .concurrent)
//queue.async {
//    // Money withdrawal from ATM
//    do {
//        let atm = Atm()
//        try atm.withDrawAmount(amount: 10000) // withdraw 10K
//        atm.printMessage()
//    } catch WithdrawalError.inSufficientAccountBalance {
//        debugPrint("ATM withdrawal failure: The account balance is less than the amount you want to withdraw, transaction cancelled")
//    }
//    catch {
//        debugPrint("Error")
//    }
//}
//
//queue.async {
//    // Money withdrawal from Bank
//    do {
//        let bank = Bank()
//        try bank.withDrawAmount(amount: 25000) // withdraw 25K
//        bank.printMessage()
//    } catch WithdrawalError.inSufficientAccountBalance  {
//        debugPrint("Bank withdrawal failure: The account balance is less than the amount you want to withdraw, transaction cancelled")
//    }
//    catch{
//        debugPrint("Error")
//    }
//}





//Server
var balance = 100
let lock = NSLock()
struct ATM {
    let atmName: String
    func withdraw(value: Int) {
        lock.lock()
        print("\(self.atmName): checking if balance containing sufficent money")
        if balance >= value {
            print("\(self.atmName): Balance is sufficent, please wait while processing withdrawal")
            // sleeping for some random time, simulating a long process
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            balance = balance -  value
            print("\(self.atmName): Done: \(value) has been withdrawed")
            print("\(self.atmName): current balance is \(balance)")
        } else {
            print("\(self.atmName): Can't withdraw: insufficent balance")
        }
        lock.unlock()
    }
}


//Client
let concurrentQueue = DispatchQueue(label: "WithdrawalQueue", attributes: .concurrent)
for index in 1...50 {
    concurrentQueue.async{
        let atm = ATM(atmName: "ATM\(index)")
        atm.withdraw(value:2)
    }
}



