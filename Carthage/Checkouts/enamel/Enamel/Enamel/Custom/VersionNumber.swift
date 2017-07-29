//
//  VersionNumber.swift
//  Enamel
//
//  Created by Cotton, Jonathan (Mobile Developer) on 01/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct VersionNumber {

    public let major: Int
    public let minor: Int
    public let patch: Int
    
    public var string: String { return "\(major).\(minor).\(patch)" }
    
    public enum Error: Swift.Error {
        case unableToParse(String)
        case incompatibleFormat(String)
    }

    public init(major: Int, minor: Int, patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    public init(from string: String) throws {
        let matches = string.characters.split(separator: ".").map(String.init)
        let numbers: [Int] = try matches.map {
            guard let int = Int($0) else {
                throw Error.unableToParse(string)
            }
            return int
        }
        guard 1...3 ~= numbers.count else {
            throw Error.incompatibleFormat(string)
        }
        major = numbers[0]
        minor = numbers[1, else: 0] 
        patch = numbers[2, else: 0]
    }
}

extension VersionNumber: Equatable {
    
    public static func == (lhs: VersionNumber, rhs: VersionNumber) -> Bool {
        return lhs.major == rhs.major
            && lhs.minor == rhs.minor
            && lhs.patch == rhs.patch
    }
}

extension VersionNumber: Comparable {
    
    public static func < (lhs: VersionNumber, rhs: VersionNumber) -> Bool {
        return lhs.major == rhs.major ? lhs.minor == rhs.minor ? lhs.patch < rhs.patch : lhs.minor < rhs.minor : lhs.major < rhs.major
    }
}

extension VersionNumber: CustomStringConvertible {
    public var description: String {
        return "VersionNumber(major: \(major), minor: \(minor), patch: \(patch)"
    }
}

extension VersionNumber.Error: Equatable {

    public static func == (lhs: VersionNumber.Error, rhs: VersionNumber.Error) -> Bool {
        switch lhs {
        case .unableToParse(let l): if case .unableToParse(let r) = rhs, l == r { return true }
        case .incompatibleFormat(let l): if case .incompatibleFormat(let r) = rhs, l == r { return true }
        }
        return false
    }
}
