//
//  InfoPlist.swift
//  Enamel
//
//  Created by Cotton, Jonathan (Mobile Developer) on 07/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct InfoPlist {
    
    public let version: VersionNumber
    public let build: String
    public let configuration: String
    
    public init(version: VersionNumber, build: String, configuration: String) {
        self.version = version
        self.build = build
        self.configuration = configuration
    }
}

extension InfoPlist: Hydratable {
    
    public static func hydrate(_ hydrated: inout InfoPlist?, source data: [String : Any]) throws {
        hydrated = InfoPlist(
            version: try data.hydrate("CFBundleShortVersionString"){ try? VersionNumber(from: $0) },
            build: try data.hydrate("CFBundleVersion"),
            configuration: try data.hydrate("Configuration") // FIXME: will not be always present
        )
    }
}

public extension InfoPlist {
    
    public init(in bundle: Bundle) throws {
        guard let id = bundle.bundleIdentifier else {
            throw "Failed to extract bundle identifier from bundle \(bundle)"
        }
        if let o = InfoPlist.memoized[id] {
            self = o
            return
        }
        guard let infoDictionary = bundle.infoDictionary else {
            throw "Failed to extract Info.plist from bundle \(id)"
        }
        self = try InfoPlist(source: infoDictionary)
        InfoPlist.memoized[id] = self
    }
    
    private static var memoized: [String : InfoPlist] {
        get { return queue.sync{ atomicMemoize } }
        set { queue.sync{ atomicMemoize = newValue } }
    }
    
    private static var atomicMemoize: [String : InfoPlist] = [:]
    private static let queue = DispatchQueue(label: "uk.sky.enamel.infoplist", attributes: .concurrent)
}
