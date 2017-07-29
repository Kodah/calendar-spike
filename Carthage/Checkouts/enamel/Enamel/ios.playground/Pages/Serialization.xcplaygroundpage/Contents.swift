//: [Previous](@previous)
//: # Serialization
//: Hidratable & Dehydratable
import Enamel

struct A {
    
    var a: String
    var b: String?
    var c: String
    var d: [String:Bool]
    var nested: B
    
    struct B {
        var one: Int
        var two: Int?
        var three: Int
        var many: [Int]
    }
}

extension A: Hydratable, Dehydratable {
    
    static func hydrate(_ hydrated: inout A?, source data: [String : Any]) throws {
        hydrated = A(
            a: try data.hydrate("a"),
            b: data.hydrate("b", else: nil),
            c: data.hydrate("c", else: "c"),
            d: data.hydrate("d", else: [:]),
            nested: try data.hydrate("s")
        )
    }
    
    func dehydrate() -> [String : Any] {
        var o: [String : Any] = ["a": a, "c": c, "d": d, "s": nested.dehydrate()]
        o["b"] = b
        return o
    }
}

extension A.B: Hydratable, Dehydratable {
    
    static func hydrate(_ hydrated: inout A.B?, source data: [String : Any]) throws {
        hydrated = A.B(
            one: try data.hydrate("one"),
            two: data.hydrate("two", else: nil),
            three: data.hydrate("three", else: 3),
            many: try data.hydrateAny("many")
        )
    }
    
    func dehydrate() -> [String : Any] {
        var o: [String : Any] = ["one": one, "three": three, "many": many]
        o["two"] = two
        return o
    }
}

print("aha")

example("hydrate an array of Ints") {
    let data: [String : Any] = ["data": [1,2,3,4]]
    let ints: [Int] = try data.hydrate("data")
    print("Hydrated Ints:", ints)
}
example("hydrate an array of Hydratables") {
    let b = A.B(one: 1, two: 2, three: 3, many: [4,5,6])
    let data: [String : Any] = ["data": [b, b, b].map{ $0.dehydrate() }]
    let bs: [A.B] = try data.hydrate("data")
    print("Hydrated Bs:", bs)
}
example("hydrateAny") {
    let b = A.B(one: 1, two: 2, three: 3, many: [4,5,6])
    let data: [String : Any] = ["data": [b, b, b].map{ $0.dehydrate() } + [["stupid thing": NSNull()]]]
    print("Should print out an error but still return three hydrated `b`s:")
    let bs: [A.B] = try data.hydrateAny("data")
    print("Hydrated Bs:", bs)
}
example("Hydrate an array of nested Hydratables") {
    let a = A(
        a: "A",
        b: "B",
        c: "C",
        d: ["yes": true, "no": false],
        nested: A.B(one: 1, two: 2, three: 3, many: [4,5,6])
    )
    let datum = a.dehydrate()
    let data: [String : Any] = ["data": [datum, datum]]
    let x: [A] = try data.hydrate("data")
    print(x)
}
example("Hydrate an array of nested Hydratables with a default value case") {
    let a = A(
        a: "A",
        b: "B",
        c: "C",
        d: ["yes": true, "no": false],
        nested: A.B(one: 1, two: 2, three: 3, many: [4,5,6])
    )
    let datum = a.dehydrate()
    let data: [String : Any] = ["data": [datum, datum]]
    let x: [A] = data.hydrateAny("BAD-KEY", else: [])
    print(x)
}
example("Hydrate into an optional Hydratable") {
    let a = A(
        a: "A",
        b: "B",
        c: "C",
        d: ["yes": true, "no": false],
        nested: A.B(one: 1, two: 2, three: 3, many: [4,5,6])
    )
    let datum = a.dehydrate()
    let data: [String : Any] = ["my datum": datum]
    let x: A? = data.hydrate("my datum", else: nil)
    print(x)
}
//: Siren
example("TODO: Siren")
{
    
}

//: [Next](@next)
