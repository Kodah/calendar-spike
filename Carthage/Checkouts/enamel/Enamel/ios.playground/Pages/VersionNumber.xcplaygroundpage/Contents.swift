//: [Previous](@previous)
//: # VersionNumber

import Enamel

example("init from string")
{
    try VersionNumber(from: "1")
    try VersionNumber(from: "1.2")
    try VersionNumber(from: "1.2.3")
}
example("equality")
{
    let v = VersionNumber(major: 1, minor: 2, patch: 3)
    let v2 = try VersionNumber(from: v.string)
    v == v2
}
example("comparability")
{
    let v = try VersionNumber(from: "1.2.3")
    let v2 = try VersionNumber(from: "1.2.4")
    v2 > v
}


//: [Next](@next)
