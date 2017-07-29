//: [Previous](@previous)
//: # Sequences

import Enamel

let even: (Int) -> Bool = { $0 %== 2 }
let odd: (Int) -> Bool = not(even)

example("subscript with an else")
{
    let a = [1, 2, 3]
    print("a -> \(a)\n")
    for i in 0...3 {
        print("a.at(\(i)) → \( a.at(i) )")
        print("a[\(i), else: 0] → \( a[i, else: 0] )\n")
    }
}
example("first and last")
{
    let digits = Array(0...9)
    
    digits.index(where: even) // Standard Library
    digits.index(where: odd)  // Standard Library
    digits.lastIndex(where: even)
    digits.lastIndex(where: odd)
    
    let evens = digits.filter(even)  // Standard Library
    
    evens.all(even)
    evens.none(odd)
    evens.any(odd)
}
example("of type instead of predicate")
{
    let mix: [Any] = [0, "1", "2"]
    
    mix.index(of: String.self)
    mix.lastIndex(of: String.self)
    mix.filter(String)
    
    mix.any(Int)
    mix.none(Bool)
    mix.all(String)
}
example("append(3, unlessAny: { $0 == 3})")
{
    var a = [1, 2, 3]
    print(a, terminator: " -> ")
    a.append(3, unlessAny: { $0 == 3})
    a.append(3, ifNone: { $0 == 3 })
    a.removeEach(even)
    a.peek("odds")
}
example("removeEach{ $0 > 1 }")
{
    var a = [1, 2, 3]
    a.filter{ _ in true }
    print(a, terminator: " -> ")
    a.removeEach{ $0 > 1 }
    print(a)
}
example("filter in & out")
{
    var a = [1, 2, 3]
    print(a, terminator: " -> ")
    let (evens, odds) = [1, 2, 3].filterInOut(even)
    print("even: \(evens), odd: \(odds)")
}
example("reduce without initial value")
{
    (1...10).reduce(+)
}
example("sorted with property accessors")
{
    ["two", "three", "four"].sorted{ $0.characters.count }(<)
}
example("min element with property accessors")
{
    ["two", "three", "four"].min{ $0.characters.count }(<)
}
example("min element with property accessors")
{
    ["two", "three", "four"].max{ $0.characters.count }(<)
}

//: [Next](@next)
