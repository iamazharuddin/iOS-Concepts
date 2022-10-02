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
    let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
    for i in 1...5 {
        concurrentQueue.async {
            if Thread.isMainThread{
                print("task \(i) running in main thread")
            }else{
                print("task \(i) running in background thread")
            }
            let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            
            DispatchQueue.global(qos: .utility).async {
                let _ = try! Data(contentsOf: imgURL)
                
                DispatchQueue.main.async {
                    print("\(i) completed downloading")
                }
            }
            
            
        }
        print("\(i) executing")
    }
}

//doLongASyncTaskInConcurrentQueue()

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

doLongSyncTaskInConcurrentQueue()
