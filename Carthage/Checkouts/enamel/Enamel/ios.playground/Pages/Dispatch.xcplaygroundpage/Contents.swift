//: [Previous](@previous)
//: # Dispatch

import Enamel

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: Interval
var interval = 1.second + 250.milliseconds
assert(interval == 1.25.seconds)

//: Pausing
print("Pausing for \(interval) seconds...")
pause(for: interval)
print("Done pausing!")

//: Delaying
print("Waiting for \(interval) seconds...")
async(after: interval) {
    print("Done waiting!")
}

//: Repeating
async(after: 3.seconds, every: 1.second) { i in
    print("iteration \(i)")
    let continuing = i < 5
    if !continuing {
        print("Done iterating!")
        PlaygroundPage.current.finishExecution()
    }
    return continuing
}

//: [Next](@next)
