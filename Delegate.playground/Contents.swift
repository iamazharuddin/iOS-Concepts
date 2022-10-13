import SwiftUI
import PlaygroundSupport

PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

/*

protocol Delegate{
    func taskFinished(_ person: String)
}
    
class B {
    var  delegate:Delegate?
    func doSomething(_ manager:String) {
        print("\(manager) asked B to do something")
        delegate?.taskFinished("B")
    }
}

class A  : Delegate{
    init(b : B){
        b.delegate = self
        b.doSomething("A")
    }
    
    func taskFinished(_ person: String){
        print("\(person) has finished the tasked succesfully")
    }
}


class C : Delegate{
    init(b : B){
        b.delegate = self
        b.doSomething("C")
    }
    
    func taskFinished(_ person: String){
        print("\(person) has finished the tasked succesfully")
    }
}


var objA = A(b: B())
var objC = C(b: B())
 
*/


class B {
    var  delegate:((String) -> Void)?
    func doSomething(for manager:String) {
//        print("\(manager) asked B to do something")
//        Thread.sleep(forTimeInterval: 2)
        
//       let json =  try! Data(contentsOf: URL(string: "https://dog.ceo/api/breeds/image/random")!)
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        var req = URLRequest(url: url)
        req.httpMethod = "Get"
        let sesson = URLSession.shared.dataTask(with: req) { data, _, _ in
            let response = String(data: data!, encoding: .utf8)!
            
            do{
                let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any]
                print(dic?["message"] as! String)
                _ = AsyncImage(url: URL(string: dic?["message"] as! String))
            }catch {
                
            }
            

            self.delegate?(response)
        }
        sesson.resume()
    }
}

class A {
    init(b : B){
        b.delegate = taskFinished
        b.doSomething(for : "A")
    }
    func taskFinished(_ person:String){
//        print("\(person) has finished the tasked succesfully for A")
        print(person)
    }
}


class C{
    init(b : B){
        b.delegate = taskFinished
        b.doSomething(for : "C")
    }
    
    func taskFinished(_ person:String){
        print("\(person) has finished the tasked succesfully for C")
    }
}


let a = A(b: B())
//let c = C(b: B())

