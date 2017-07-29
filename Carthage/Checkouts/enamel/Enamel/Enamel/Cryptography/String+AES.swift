//
//  String+AES.swift
//  Enamel
//
//  Created by Wroblewski, Dominic (Developer) on 05/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public extension String {
    
    public func aes128Encrypted(_ key: String) -> String? {
        return self.data(using: .utf8)
            .map(NSData.init)?
            .aes128Encrypted(withKey: key)
            .base64EncodedString()
    }

    public func aes128Decrypted(_ key: String) -> String? {
        return NSData(base64Encoded: self)?
            .aes128Decrypted(withKey: key)?
            .string(encoding: .utf8)
    }
    
    @available(*, unavailable, renamed: "aes128Encrypted(_:)")
    public func AES128Encrypted(_ key: String) -> String { return "" }
    
    @available(*, unavailable, renamed: "aes128Decrypted(_:)")
    public func AES128Decrypted(_ key: String) -> String? { return nil }
}

