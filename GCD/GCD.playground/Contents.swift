import UIKit

func doLongAsyncTaskInSerialQueue() {
   let serialQueue = DispatchQueue(label: "com.queue.Serial")
      for i in 1...5 {
        serialQueue.async {

            if Thread.isMainThread{
                print("task \(i) running in main thread")
            }else{
                print("task \(i) running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
        }
    }
}


// doLongAsyncTaskInSerialQueue()


func doLongSyncTaskInSerialQueue() {
    let serialQueue = DispatchQueue(label: "com.queue.Serial")
    for i in 1...5 {
        serialQueue.sync {
            if Thread.isMainThread{
                print("task \(i) running in main thread")
            }else{
                print("task \(i) running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
        }
    }
}

//doLongSyncTaskInSerialQueue()

func doLongASyncTaskInConcurrentQueue() {
//    let semaphore = DispatchSemaphore(value:  1)
//    let lock = NSLock()
    let group = DispatchGroup()
    let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
    for i in 1...5 {
        group.enter()
        
        concurrentQueue.async{
//            semaphore.wait()
//            lock.lock()
            if Thread.isMainThread{
                print("task \(i) running in main thread")
            }else{
                print("task \(i) running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
//            semaphore.signal()
//            lock.unlock()
            
            group.leave()
        }
        print("\(i) executing")
    }
    
    print("image download completed")
    
//    group.notify(queue: .main) {
//        print("image download completed")
//    }
}

doLongASyncTaskInConcurrentQueue()

func doLongSyncTaskInConcurrentQueue() {
  let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
    for i in 1...5 {
        concurrentQueue.sync {
            if Thread.isMainThread{
                print("task \(i) running in main thread")
            }else{
                print("task \(i) running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imgURL)
            print("\(i) completed downloading")
        }
        print("\(i) executed")
    }
}

//doLongSyncTaskInConcurrentQueue()
