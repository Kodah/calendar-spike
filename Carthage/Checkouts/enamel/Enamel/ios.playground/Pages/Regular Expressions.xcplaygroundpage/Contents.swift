//: [Previous](@previous)
//: # Regular Expressions
import Enamel

let sky = try! ".+\\.sky\\.com".regex(.i)
let clouds = "(cloud){2,}".regex!
let birds = try! "(bird){2,}".regex(.caseInsensitive, .ignoreMetacharacters)

let string = "http://my.sky.com"

sky ~= string

switch string
{
case clouds: "it's the clouds!"
case birds: "it's the birds!"
case sky: "it's the sky!"
default: "god knows what it is!"
}

//: [Next](@next)
