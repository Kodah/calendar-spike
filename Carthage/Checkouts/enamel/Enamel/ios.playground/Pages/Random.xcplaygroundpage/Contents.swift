//: [Previous](@previous)
//: # Random
import Enamel

example("random Bool")
{
    50.of{ Bool.random ? 1 : 0 }
}
example("random unsigned integers")
{
    UInt.random
    UInt8.random
    UInt16.random
    UInt32.random
    UInt64.random
    UIntMax.random

    50.of{ UInt8.random } // 🖥 show result
}
example("radom integer from a closed range")
{
    "⭐" * (1...5).random // 🖥 show result
    50.of{ (Int.min...Int.max).random } // 🖥 show result
}
//: ### Sampling & Shuffling
example("sampling & shuffling collections")
{
    (1...5).shuffled
    ["a": 1, "b": 2, "c": 3].sample
    "abc".characters.sample
    let mood = "😀😂😪😱😡🤕😴"
    mood.sample
    mood.shuffled
}
//: ### Random `CGFloat`s
example("random CGFloat between 0 and 1")
{
    CGFloat.random
    CGFloat.randomMaxRes
}
example("random number between x and y")
{
    200.of{ CGFloat.random(between: -5, and: 5).d } // 🖥 show result
    200.of{ CGFloat.random(between: 0, and: 1, power: 3, pivot: 0.75).d } // 🖥 show result
}
example("random walk")
{
    for x in CGFloat.randomWalk(count: 200, initial: 0, range: 0.1) {
        x.d // 🖥 show result
    }
    for x in CGFloat.randomWalk(count: 200, initial: 0, range: 0.1) {
        x.clamped(to: (-0.1)...0.1).d // 🖥 show result
    }
}

//: [Next](@next)
