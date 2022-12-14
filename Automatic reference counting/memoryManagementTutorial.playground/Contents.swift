import UIKit



class Person
{
    var name: String
    var job: Job?

    init(_name: String) {
        debugPrint("init method of Person called")
        name = _name
    }

    func printName() {
        debugPrint("name is \(name)")
    }

    deinit {
        debugPrint("deinit called for person class")
    }
}

//var objPerson1: Person?
//var objPerson2: Person?
//
//if (1 == 1)
//{
//    let objPerson = Person(_name: "codect15")
//    objPerson1 = objPerson
//    objPerson2 = objPerson
//    objPerson.printName()
//}

class Job
{
    var jobDescription: String
    var person: Person?

    init(_jobDescription: String) {
        debugPrint("init method of Job called")
        jobDescription = _jobDescription
    }

    deinit {
        debugPrint("deinit called for job class")
    }
}

if (1 == 1)
{
    let objPerson = Person(_name: "codect15")
    let objJob = Job(_jobDescription: "swift programmer")
    objPerson.job = objJob
    objJob.person = objPerson
}


