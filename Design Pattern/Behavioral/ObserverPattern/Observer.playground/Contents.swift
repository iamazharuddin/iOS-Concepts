// Example - 1
/*
 Behavioral Design Pattern deals with how objects interact. It describes how objects communicates with each other and how the steps of a task is broken among different objects so as to provide more flexibility and make the code more testable.
 */
import Foundation
import UIKit
struct TrafficColor
{
    static let red = "red"
    static let green = "green"
    static let yellow = "yellow"
}

protocol ObserverProtocol
{
    var Id : Int {get set}
    func onTrafficLightColorChange(_color: String)
}

class VehicleObserver : ObserverProtocol
{
    var Id: Int
    
    init(_Id : Int) {
        Id = _Id
    }
    
    func onTrafficLightColorChange(_color: String)
    {
        if(_color == TrafficColor.red)
        {
            debugPrint("stop my vehicle")
        }
        if(_color == TrafficColor.green)
        {
            debugPrint("start my vehicle")
        }
        if(_color == TrafficColor.yellow)
        {
            debugPrint("slow down the speed of my vehicle")
        }
    }
}

class VendorObserver : ObserverProtocol
{
    var Id: Int
    
    init(_Id : Int) {
        Id = _Id
    }
    
    func onTrafficLightColorChange(_color: String)
    {
        if(_color == TrafficColor.red)
        {
            debugPrint("Vendor: Start selling products")
        }
        if(_color == TrafficColor.green)
        {
            debugPrint("Vendor: Move aside from the traffic")
        }
    }
}


class TrafficLightSubject
{
    private var _color  = String()
    
    var trafficLightColor : String
    {
        get
        {
            return _color
        }
        set
        {
            _color = newValue
            notifyObserver()
        }
    }
    
    private var trafficObserver = [ObserverProtocol]()
    
    func addObserver(_observer: ObserverProtocol)
    {
        guard trafficObserver.contains(where: {$0.Id == _observer.Id}) == false else {
            return
        }
        trafficObserver.append(_observer)
    }
    
    func removeObserver(_observer: ObserverProtocol)
    {
        trafficObserver = trafficObserver.filter({$0.Id != _observer.Id})
    }
    
    private func notifyObserver()
    {
        trafficObserver.forEach({$0.onTrafficLightColorChange(_color: _color)})
    }
    
    deinit {
        trafficObserver.removeAll()
    }
}

let trafficLightSubject = TrafficLightSubject()
let vehicleObserver = VehicleObserver(_Id: 1)
let vendorObserver = VendorObserver(_Id: 2)

trafficLightSubject.addObserver(_observer: vehicleObserver)
trafficLightSubject.addObserver(_observer: vendorObserver)

trafficLightSubject.trafficLightColor = TrafficColor.red

trafficLightSubject.removeObserver(_observer: vendorObserver)

trafficLightSubject.trafficLightColor = TrafficColor.green

//  Exmaple - 2

import XCTest

/// The Subject owns some important state and notifies observers when the state
/// changes.
class Subject {

    /// For the sake of simplicity, the Subject's state, essential to all
    /// subscribers, is stored in this variable.
    var state: Int = { return Int(arc4random_uniform(10)) }()

    /// @var array List of subscribers. In real life, the list of subscribers
    /// can be stored more comprehensively (categorized by event type, etc.).
    private lazy var observers = [Observer]()

    /// The subscription management methods.
    func attach(_ observer: Observer) {
        print("Subject: Attached an observer.\n")
        observers.append(observer)
    }

    func detach(_ observer: Observer) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
            print("Subject: Detached an observer.\n")
        }
    }

    /// Trigger an update in each subscriber.
    func notify() {
        print("Subject: Notifying observers...\n")
        observers.forEach({$0.update(subject: self)})
    }

    /// Usually, the subscription logic is only a fraction of what a Subject can
    /// really do. Subjects commonly hold some important business logic, that
    /// triggers a notification method whenever something important is about to
    /// happen (or after it).
    func someBusinessLogic() {
        print("\nSubject: I'm doing something important.\n")
        state = Int(arc4random_uniform(10))
        print("Subject: My state has just changed to: \(state)\n")
        notify()
    }
}

/// The Observer protocol declares the update method, used by subjects.
protocol Observer: AnyObject {
    func update(subject: Subject)
}

/// Concrete Observers react to the updates issued by the Subject they had been
/// attached to.
class ConcreteObserverA: Observer {

    func update(subject: Subject) {

        if subject.state < 3 {
            print("ConcreteObserverA: Reacted to the event.\n")
        }
    }
}

class ConcreteObserverB: Observer {

    func update(subject: Subject) {

        if subject.state >= 3 {
            print("ConcreteObserverB: Reacted to the event.\n")
        }
    }
}

/// Let's see how it all works together.
class ObserverConceptual: XCTestCase {

    func testObserverConceptual() {

        let subject = Subject()

        let observer1 = ConcreteObserverA()
        let observer2 = ConcreteObserverB()

        subject.attach(observer1)
        subject.attach(observer2)

        subject.someBusinessLogic()
        subject.someBusinessLogic()
        subject.detach(observer2)
        subject.someBusinessLogic()
    }
}


let test = ObserverConceptual()
test.testObserverConceptual()


//  Example - 3



// Observer
protocol PropertyObserver : AnyObject {
    func willChange(propertyName: String, newPropertyValue: Any?)
    func didChange(propertyName: String, oldPropertyValue: Any?)
}

final class TestChambers {
    weak var observer:PropertyObserver?
    private let testChamberNumberName = "testChamberNumber"
    var testChamberNumber: Int = 0 {
        willSet(newValue) {
            observer?.willChange(propertyName: testChamberNumberName, newPropertyValue: newValue)
        }
        didSet {
            observer?.didChange(propertyName: testChamberNumberName, oldPropertyValue: oldValue)
        }
    }
}

final class Observer : PropertyObserver {
    func willChange(propertyName: String, newPropertyValue: Any?) {
        if newPropertyValue as? Int == 1 {
            print("Okay. Look. We both said a lot of things that you're going to regret.")
        }
    }

    func didChange(propertyName: String, oldPropertyValue: Any?) {
        if oldPropertyValue as? Int == 0 {
            print("Sorry about the mess. I've really let the place go since you killed me.")
        }
    }
}


var observerInstance = Observer()
var testChambers = TestChambers()
testChambers.observer = observerInstance
testChambers.testChamberNumber += 1






/*
 enum NotificationCenterError: Error {
     case notificationNotFound
 }

 final class MyNotificationCenter {
     static let shared = MyNotificationCenter()
     
     // Storing first string as a class name nested with notification name
     // Which is further nested with closure to execute when notification is posted
     private var notificationsStorage: [String: [String: [(String, Any) -> Void]]]

     private init() {
         notificationsStorage = [:]
     }

     func addObserver(_ _class: Any, name: String, closure: @escaping (String, Any) -> Void) {
         guard let inputClass = type(of: _class) as? AnyClass else {
             return
         }
         let className = String(describing: inputClass)
         if notificationsStorage[className] != nil && notificationsStorage[className]?[name] != nil {
             
             notificationsStorage[className]?[name]?.append(closure)
             
         } else if notificationsStorage[className] != nil {
             
             if notificationsStorage[className]?[name] == nil {
                 notificationsStorage[className]?[name] = [closure]
             } else {
                 notificationsStorage[className]?[name]?.append(closure)
             }
         }
         else {
             notificationsStorage[className] = [name: [closure]]
         }
     }

     func removeObserver(_ _class: Any) throws {
         
         guard let inputClass = type(of: _class) as? AnyClass else {
             return
         }
         
         let className = String(describing: inputClass)
         
         guard notificationsStorage[className] != nil else { throw NotificationCenterError.notificationNotFound }
         notificationsStorage.removeValue(forKey: className)
     }

     func postNotification(_ name: String, object: Any) throws {
         
         var atLeastOneNotificationFound = false
         for (_, notificationData) in notificationsStorage {
             for (notificationName, closures) in notificationData {
                 guard notificationName == name else { continue }
                 for closure in closures {
                     atLeastOneNotificationFound = true
                     closure(name, object)
                 }
             }
         }
         
         if !atLeastOneNotificationFound {
             throw NotificationCenterError.notificationNotFound
         }
     }
 }




 class Test {

     func foo() {
         let notificationCenter = MyNotificationCenter.shared
         
 //        notificationCenter.addObserver(self, name: "one") { _, _ in
 //            print("one")
 //        }
         
         notificationCenter.addObserver(self, name: "one") { str, anyobject in
             print("notification recieved", str, anyobject)
         }
         
        try? notificationCenter.removeObserver(self)
         
 //        notificationCenter.addObserver(self, name: "one") { _, _ in
 //            print("one one")
 //        }
 //
 //        notificationCenter.addObserver(self, name: "one") { _, _ in
 //            print("one one one")
 //        }
 //
         notificationCenter.addObserver(self, name: "two") { str, anyobject in
             print("notification recieved", str, anyobject)
         }

         notificationCenter.addObserver(self, name: "three") { _, _ in
             print("Three")
         }
         

     }
 }

 Test().foo()
 let notificationCenter = MyNotificationCenter.shared
 _ = try? notificationCenter.postNotification("one", object: "None")
 _ = try? notificationCenter.postNotification("two", object: "None")
 _ = try? notificationCenter.postNotification("three", object: "None")

 */
