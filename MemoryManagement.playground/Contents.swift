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


