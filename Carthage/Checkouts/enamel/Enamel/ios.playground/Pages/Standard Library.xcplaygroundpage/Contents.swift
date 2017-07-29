//: [Previous](@previous)
//: # Standard Library
import Enamel
//: ### RawRepresentable
example("enum compare & init")
{
    enum N: Int {
        case zero, one, two, three
    }
    N.two < .three
    (0...10).flatMap(N.init)
}
//: ### Optional
example("avoid parenthesis with nil-coalescing operator")
{
    let data: [String:Any] = ["a": 1, "b": ["x": 0]]
    data["a"].map(Int) == 1
    data["?"].unwrapped(else: 1) + 1
}
example("forSome / unlessNil / ifNotNil")
{
    let data = ["a": 1]
    data["a"].unlessNil{ print("Prints \($0), never nil") }
}
example("unwrap or throw")
{
    try Int("five").unwrap(orThrow: "Not a number!")
}
example("unwrap or throw operator ??^")
{
    try Int("five") ??^ "Not a number!"
}
example("map all or nothing")
{
    try? ["1", "2", "tree"]
        .map{ try Int($0).unwrap() }
}
example("force unwrap in DEBUG, else use default value")
{
    let x: Int? = 4
    let y: Int? = nil
    
    x.forceUnwrappedInDEBUG(else: 3) * 10
    y.forceUnwrappedInDEBUG(else: 3) * 10
    
    (x ??! 3) * 10
    (y ??! 3) * 10
}
//: ### Int
example("is divisible")
{
    let isEven = { $0 %== 2 }
    let (even, odd) = (1...10).filterInOut(isEven)
    even
    odd
    let o = (1...100).filter{ $0 %== [2, 3, 7] }
    print("Divisible by 2, 3 and 7: \(o)")
}
example("clamp to closed range") {
    let digits = 0...9
    let clamped = (-2...11).map(digits.clamp)
}
example("clamp to half-open range") {
    let digits = 0..<10
    let clamped = (-2...11).map(digits.clamp)
}
example("max integer arithmetic (without blowing up)")
{
    UIntMax.max.plusMinIntMax
    UIntMax(0).plusMinIntMax
    IntMax.max.unsignedDistanceTo(IntMax.min)
    IntMax(1).unsignedDistanceFromMin
}
example("sum & product") {
    (1...10).sum
    (1...10).product
}

//: ### String
example("throwing a string")
{
    do {
        throw "Blah!"
    } catch {
        print("threw", error)
    }
}
example("lastPOSIXPathComponent")
{
    let file = "somewhere/over/the/rainbow.json"
    file.lastPOSIXPathComponent.peek()
    
    let test: (String) -> () = {
        let a = $0.lastPOSIXPathComponent
        let b = NSString(string: $0).lastPathComponent
        guard a == b else { fatalError("'\(a)' != '\(b)'") }
    }
    
    let cases = [
        "/tmp/scratch.tiff",
        "/tmp/scratch",
        "/tmp/",
        "scratch///",
        "",
        "/",
        "//"
    ]
    
    cases.forEach(test)

    print(
        "passed all the test cases from the",
        "<NSString>.lastPathComponent documentation"
    )
}

//: ### Dictionary
let shared: [String:Any] = [
    "a": 1,
    "b": 2,
    "c": [
        "d": [
            "e": [
                ["f": 2],
                ["e": 1, "f": 2]
            ]
        ],
        "g": 2
    ]
]
let custom: [String:Any] = [
    "c": [
        "d": [
            "e": [
                ["f": 2],
                ["e": 10, "f": 20]
            ]
        ]
    ]
]
example("merge")
{
    let settings = shared.merging(custom)
    let c = settings.peek()["c"] as! [String:Any]
    assert(c["g"] == nil)
}
example("deep merge")
{
    let settings = shared.deepMerging(custom)
    let c = settings.peek()["c"] as! [String:Any]
    assert(c["g"] as! Int == 2)
}
example("init with a sequence of pairs")
{
    let o = Dictionary([(1, "a"), (2, "b")])
    let pairs = o.array
    Dictionary(pairs).peek()
}
example("zip → dictionary")
{
    let d = zip(65...67, "ABC".characters).dictionary
}
example("plusing dictionaries")
{
    let d = [1: "A", 3: "c"] + [1: "a", 2: "b"]
}
example("subscript with default value")
{
    var d: [String:Int] = [:]
    for i in 1...7 {
        if i %== 2 {
            d["even", else: 0] += 1
        } else { 
            d["odd", else: 0] += 1
        }
    }
    print("total", d)
}
example("type casting access")
{
    let d: [String:Any] = [
        "person": [
            "address": [
                "streetNumber": 21
            ]
        ]
    ]
    try d
        .branch("person", "address")
        .get("streetNumber", as: Int.self) * 2
    try d
        .branch("person", "address")
        .get("numOccupants", else: 0) + 1
}
//: ### Free Functions
example("pipe & map forward")
{
    1...5 |>> {$0 * $0} |>> String.init |> [String].joined § ", "
}
example("appease the compiler while architecting")
{
    func isIdeal(location: CGPoint) -> Bool {
        TODO
    }
}
example("assert impossible code path")
{
    switch abs( (-5...5).random )
    {
    case 0: "zero"
    case 1...5: "positive"
    default: IMPOSSIBLE
    }
}

//: [Next](@next)
