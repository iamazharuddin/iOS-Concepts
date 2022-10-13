import Foundation
let semaphore = DispatchSemaphore(value: 1)
func asyncTask(_ i : Int){
     semaphore.wait()
     if Thread.isMainThread{
        print("Task \(i) Executing in main thread")
     }else{
         print("Task \(i) Executing in background thread")
     }
     Thread.sleep(forTimeInterval: 2)
     print("Task \(i) finished")
     semaphore.signal()
}


func executeMultipleAsyncTask(){
    let queue = DispatchQueue(label: "com.azhar.com", attributes: .concurrent)
    for i in 1...5{
        queue.async{
            asyncTask(i)
        }
    }
}
executeMultipleAsyncTask()
