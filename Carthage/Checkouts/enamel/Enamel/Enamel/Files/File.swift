//
//  File.swift
//  Enamel
//
//  Created by Cotton, Jonathan (Mobile Developer) on 30/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public final class File {
    
    public let name: String
    public let type: String?
    public let bundle: Bundle
    public let encoding: String.Encoding
    
    public private(set) lazy var data: Data? = try? self.loadData()
    public private(set) lazy var string: String? = try? self.loadString()
    public private(set) lazy var json: [String : Any]? = try? self.loadJson()
    public private(set) lazy var jsonArray: [[String : Any]]? = try? self.loadJsonArray()
    
    public init(_ name: String, in bundle: Bundle, using encoding: String.Encoding = .utf8) {
        self.name = (name as NSString).deletingPathExtension
        self.type = (name as NSString).pathExtension
        self.bundle = bundle
        self.encoding = encoding
    }
    
    public convenience init<Name>(_ name: Name, in bundle: Bundle, using encoding: String.Encoding = .utf8)
        where
        Name: RawRepresentable,
        Name.RawValue == String
    {
        self.init(name.rawValue, in: bundle, using: encoding)
    }
}

public extension File {

    public func loadData() throws -> Data {
        return try loadData(type: type ??^ Error.fileNameDoesNotContainExtension)
    }

    public func loadString() throws -> String {
        return try loadData(type: type ??^ Error.fileNameDoesNotContainExtension)
            .string(encoding: encoding) ??^ Error.unableToDecode
    }

    public func loadJson() throws -> [String : Any] {
        return try loadData(type: "json")
            .jsonDictionary() ??^ Error.unableToParseAsJson
    }

    public func loadJsonArray() throws -> [[String : Any]] {
        return try loadData(type: "json")
            .jsonArray() ??^ Error.unableToParseAsJson
    }

    private func loadData(type: String) throws -> Data {
        guard let url = bundle.url(forResource: name, withExtension: type) else {
            throw Error.doesNotExist("\(name).\(type)")
        }
        guard let data = try? Data(contentsOf: url, options: .uncached) else {
            throw Error.unableToDecode
        }
        guard data.count > 0 else {
            throw Error.empty
        }
        return data
    }
}

extension File: Equatable {
    
    public static func == (lhs: File, rhs: File) -> Bool {
        return lhs.name == rhs.name
            && lhs.type == rhs.type
            && lhs.bundle === rhs.bundle
            && lhs.encoding == rhs.encoding
    }
}

public extension File {
    
    public enum Error: Swift.Error {
        case doesNotExist(String)
        case empty
        case unableToDecode
        case fileNameDoesNotContainExtension
        case unableToParseAsJson
    }
}

extension File.Error: Equatable {
    
    public static func == (lhs: File.Error, rhs: File.Error) -> Bool {
        switch lhs
        {
        case .doesNotExist(let l): if case .doesNotExist(let r) = rhs { return l == r }
        case .empty: return rhs == .empty
        case .unableToDecode: return rhs == .unableToDecode
        case .fileNameDoesNotContainExtension: return rhs == .fileNameDoesNotContainExtension
        case .unableToParseAsJson: return rhs == unableToParseAsJson
        }
        return false
    }
}
