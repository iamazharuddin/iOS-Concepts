import UIKit
protocol TodoDelegate {
    func sendCompleted(_ todo: Todo)
}

class Notifications : TodoDelegate {
    var message: String?
    var sent: Bool = false

    init() {
    }
    
    func sendCompleted(_ todo: Todo) {
        print("Completed: \(todo.task)")
    }

}

class Todo {
    var task: String
    var completed: Bool = false
    var delegate : TodoDelegate?
    init(task_name: String) {
        task = task_name
    }
    func complete() {
        if completed == false {
            completed = true
            delegate?.sendCompleted(self)
        }
    }
}

//let del = Notifications()
//
//let td = Todo(task_name: "Get Cheese")
//td.delegate = del
//td.complete()
//let tr = Todo(task_name: "Dont' forget the honey")
//tr.delegate = del
//tr.complete()


protocol TodoCompletedDelegate{
    func todoCompleted(_ task : Todo1)
}

class Notifications1 : TodoCompletedDelegate{
    func todoCompleted(_ task :Todo1){
        print("completed: \(task.task)")
    }
}


class Todo1 {
    let task:String
    var delegate : TodoCompletedDelegate?
    init(task_name:String) {
        self.task = task_name
    }
        
    func complete(){
        delegate?.todoCompleted(self)
    }
}

let del = Notifications1()

let td = Todo1(task_name: "Get Cheese")
td.delegate = del
td.complete()
let tr = Todo1(task_name: "Dont' forget the honey")
tr.delegate = del
tr.complete()



//
//let del = Notifications()
//
//let td = Todo(task_name: "Get Cheese")
//td.delegate = del
//td.complete()
//let tr = Todo(task_name: "Dont' forget the honey")
//tr.delegate = del
//tr.complete()
