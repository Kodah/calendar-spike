//: [Previous](@previous)
//: # Debugging utilities

import Enamel

example("peek & poke")
{
    let five = 1...5
    five.poke("count", { $0.count })
        .map{ $0.peek("element").advanced(by: 1) }
        .peek("one up")
}
example("note")
{
    note(Date())
}
example("path")
{
    print("I'm here: \(path())")
}
example("measure")
{
    let measureTask2 = { measure(end: "task 2") }
    
    measure(start: "task 1")
    measure(start: "task 2")
    
    pause(for: 1.second)
    
    measure(end: "task 1")
    
    pause(for: 1.second)
    
    measureTask2()
    
    pause(for: 1.seconds)
}
example("string from URLSession's error response")
{
    let data = Data(json: ["success": true])
    let response = HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 401,
        httpVersion: "HTTP/1.1",
        headerFields: ["field 1": "aha", "field 2": "oho"]
    )
    let error = NSError(
        domain: "error domain",
        code: 13,
        userInfo: ["info": 1]
    )
    print(String(from: data, response, error))
}


//: [Next](@next)
