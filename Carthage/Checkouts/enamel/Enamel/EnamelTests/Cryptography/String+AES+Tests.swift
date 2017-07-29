//
//  String+AES+Tests.swift
//  Enamel
//
//  Created by Wroblewski, Dominic (Developer) on 05/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Crack

class String_AES_Tests: XCTestCase {

    func test_aes_encrypt_on_String() {
        let encryptedString = "Message".aes128Encrypted("secret")
        assert(encryptedString) == "/eBsajB7CHWRoSx1j+wlEg=="
    }

    func test_aes_decrypt_on_String() {
        let decryptedString = "/eBsajB7CHWRoSx1j+wlEg==".aes128Decrypted("secret")
        assert(decryptedString) == "Message"
    }
}
