import Foundation
let semaphore = DispatchSemaphore(value: 1)
func asyncTask(_ i : Int){
     if Thread.isMainThread{
        print("Task \(i) Executing in main thread")
     }else{
         print("Task \(i) Executing in background thread")
     }
     Thread.sleep(forTimeInterval: 2)
     print("Task \(i) finished")
}


func executeMultipleAsyncTask(){
    let queue = DispatchQueue(label: "com.azhar.com", attributes: .concurrent)
    for i in 1...5{
        queue.async{
            asyncTask(i)
        }
    }
}
//executeMultipleAsyncTask()
func executeMultipleWorkItem(){
    let queue = DispatchQueue(label: "com.azhar.com", attributes: .concurrent)
    for i in 1...5{
        let workItem = DispatchWorkItem{
            asyncTask(i)
        }
        if i == 2{
            workItem.cancel()
        }
        workItem.notify(queue: .main) {
            print("Task \(i) finished")
        }
        queue.async(execute: workItem)
    }
}


//executeMultipleWorkItem()



let queue = DispatchQueue(label: "com.azhar.com", attributes: .concurrent)
queue.sync(flags:.barrier) {
    
    if Thread.isMainThread{
       print("Executing in main thread")
    }else{
        print("Executing in background thread")
    }
    
    var str = ""
    Thread.sleep(forTimeInterval: 2)
    for i in 1...5{
      str = str + " " + String(i)
    }
    print(str)
}

queue.async {
    
    if Thread.isMainThread{
       print("Executing in main thread")
    }else{
        print("Executing in background thread")
    }
    
    var str = ""
    for i in stride(from: 100, to: 1, by: -10){
      str = str + " " + String(i)
    }
  
    print(str)
}






let q = DispatchQueue.global()
     q.sync {
         if Thread.isMainThread{
             print("Main thread")
         }

         print("1")

         q.sync {
             if Thread.isMainThread{
                 print("Main thread")
             }else{
                 print("background thread")
             }
             print("2")
             
             q.sync {
                 print("3")
             }
         }

         print("4")
     }

  q.sync {
    print("5")
 }
