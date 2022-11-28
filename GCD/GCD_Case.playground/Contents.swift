/*
 async - concurrent: the code runs on a background thread. Control returns immediately to the main thread (and UI). The block can't assume that it's the only block running on that queue
 async - serial: the code runs on a background thread. Control returns immediately to the main thread. The block can assume that it's the only block running on that queue
 sync - concurrent: the code runs on a background thread but the main thread waits for it to finish, blocking any updates to the UI. The block can't assume that it's the only block running on that queue (I could have added another block using async a few seconds previously)
 sync - serial: the code runs on a background thread but the main thread waits for it to finish, blocking any updates to the UI. The block can assume that it's the only block running on that queue
 
 If you call the sync function on the main queue it will block the queue as well as the queue will be waiting for the task to be completed but the task will never be finished since it will not be even able to start due to the queue is already blocked. It is called deadlock.
 */

import Foundation
func doLongAsyncTaskInSerialQueue() {
   let serialQueue = DispatchQueue(label: "com.queue.Serial")
      for i in 1...5 {
        serialQueue.async {
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
        }
    }
}


func doLongSyncTaskInSerialQueue() {
    let serialQueue = DispatchQueue(label: "com.queue.Serial")
    for i in 1...5 {
        serialQueue.sync {
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
        }
    }
}


func doLongASyncTaskInConcurrentQueue() {
    let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
    for i in 1...5 {
        concurrentQueue.async {
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
        }
        print("\(i) executing")
    }
}


func doLongSyncTaskInConcurrentQueue() {
  let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
    for i in 1...5 {
        concurrentQueue.sync {
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
        }
        print("\(i) executed")
    }
}



func executeMultipleWorkItem(){
    let queue = DispatchQueue(label: "com.azhar.com", attributes: .concurrent)
    for i in 1...5{
        let workItem = DispatchWorkItem{
            Thread.sleep(forTimeInterval: 2)
            print("Task \(i) done")
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



// assessment question 1
let q = DispatchQueue.global()
q.sync {
    print("1")
    q.sync {
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
