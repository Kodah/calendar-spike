//: [Previous](@previous)
//: # HasID

import Enamel

struct A: HasID {
    
    let id: ID
    
    init() {
        id = ID()
    }
    
    init(from other: A) {
        id = other.id.newVersion
    }
}

let a = A()

let aCopy = a
aCopy.derives(from: a) // false
aCopy.sameVersion(of: a) // true
aCopy == a // true
aCopy === a // true

let a2 = A(from: a)
a2.derives(from: a) // true
a2.sameVersion(of: a) // false
a2 == a // true
a2 === a // false

//: [Next](@next)