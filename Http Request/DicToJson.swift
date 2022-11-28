import Foundation
let dic : [String : Any] = [ "1" : 1 , "2" : 2]
let jsonData = try! JSONSerialization.data(withJSONObject: dic,  options: [.prettyPrinted])
let jsonObject  = try! JSONSerialization.jsonObject(with: jsonData)
let string = String(data: jsonData, encoding: .ascii)!
let dataFromString = string.data(using: .ascii)!
print("orignal dic ==== \(dic)")
print("jsonData ==== \(jsonData)")
print("jsonObject ==== \(jsonObject)")
print("ascii formatted String from data ==== ", string)
print("dataFromString ==== \(dataFromString)")


func dictoJson(_ dic : [AnyHashable:Any]) -> String?{
    guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                        options: [.prettyPrinted]) else {
        return nil
    }
    return String(data: theJSONData, encoding: .ascii)
}
