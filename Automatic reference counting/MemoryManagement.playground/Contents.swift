import UIKit
class A{
    weak var b : B?
    init(){
        print("Class A init is called")
    }
    
    deinit {
        print("Class A deinit is called")
    }
}

class B{
    weak var a : A?
    init(){
        print("Class B init is called")
    }
    
    deinit {
        print("Class B deinit is called")
    }
}

if 1 == 1{
    let a = A()
    let b = B()
    a.b = b
    b.a = a
}



func findPair(_ nums:[Int], _ k : Int ) -> [Int]{
    var set = Set<Int>()
    for n in nums{
         if set.contains(k-n){
            return [n, k-n]
         }
         set.insert(n)
    }
    return [-1]
}
let ans = findPair([2, 4, 8, 6, 3, 12], 11)
//print(ans)




    


//print("Step 1")
//print(myFunc())
//print("Step 5")
//
//func myFunc() -> String {
//    defer {
//        print("Step 3")
//    }
//    print("Step 2")
//    return "Step 4"
//}



