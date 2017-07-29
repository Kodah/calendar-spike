//: [Previous](@previous)
//: # SelflessEquatable
import Enamel

protocol P: Equatable {}

struct A: P {
    static func == (l: A, r: A) -> Bool { return true }
}

struct B: P {
    static func == (l: B, r: B) -> Bool { return true }
}

let (a, b) = ( A(), B() )
/*:
    let collection: [P] = [a, b] // error: protocol 'P' can only be used as a generic constraint because it has Self or associated type requirements
*/
protocol Q: SelflessEquatable {}

extension A: Q {}

extension B: Q {}

let collection: [Q] = [a, b]
collection.elementsSelflessEqual([a, b])

//: [Next](@next)
