//: [Previous](@previous)
//: # Dictionry.branch
//: Throws a `BranchingError` when attempting to access a value whose type is not the same as the type of the dictionary as a whole.
import Enamel

let data: [String:Any] = [
    "a": 1,
    "b": 1,
    "c": [
        "a": [
            "a": [
                ["a": 1],
                ["a": 1, "b": 1]
            ]
        ],
        "b": 1
    ]
]
example("throw BranchingError if its not a branch")
{
    try data.branch(["a"])
}
example("throw BranchingError if there's no such key")
{
    try data.branch("BAD_KEY")
}
example("branch at depth 1")
{
    try data.branch("c")
}
example("branch at depth 2")
{
    try data.branch("c", "a")
}
example("branches in an array")
{
    try data.branches("c", "a", "a")
}
example("branch in an array")
{
    try data
        .branch("c", "a")
        .branch("a", where: { $0["b"].isNotNil })
}
example("throw BranchingError if predicate fails")
{
    try data.branch("c", "a")
        .branch("a", where: { $0["BAD_KEY"].isNotNil })
}
//: ### Capcha examples
let entity = try! Data(contentsOf: #fileLiteral(resourceName: "captcha.json")).jsonDictionary()!

let classIs: (String) -> ([String:Any]) -> Bool = { name in
    { $0["class"].map([String])?.contains{ $0 == name } ?? false }
}

let nameIs: (String) -> ([String:Any]) -> Bool = { name in
    { $0["name"].map(String) == name }
}

example("entities/{class: [captcha]}/actions/{name: request-captcha}/href")
{
    try entity
        .branch("entities", where: classIs("captcha"))
        .branch("actions", where: nameIs("request-captcha"))
        .hydrate("href", transform: URL.init(string:)) as URL
}

//: [Next](@next)
