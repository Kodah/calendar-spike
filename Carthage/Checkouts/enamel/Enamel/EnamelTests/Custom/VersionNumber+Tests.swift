//
//  VersionNumber+Test.swift
//  Enamel
//
//  Created by Cotton, Jonathan (Mobile Developer) on 01/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Crack

class VersionNumberTests: XCTestCase {
    func test_string_init_with_only_major() {
        let version = try? VersionNumber(from: "1")
        let expectation = VersionNumber(major: 1, minor: 0, patch: 0)
        assert(version) == expectation
    }

    func test_string_init_with_only_major_and_minor() {
        let version = try? VersionNumber(from: "1.2")
        let expectation = VersionNumber(major: 1, minor: 2, patch: 0)
        assert(version) == expectation
    }

    func test_string_init_with_major_minor_and_patch() {
        let version = try? VersionNumber(from: "1.2.3")
        let expectation = VersionNumber(major: 1, minor: 2, patch: 3)
        assert(version) == expectation
    }

    func test_version_number_equality() {
        let version1 = VersionNumber(major: 1, minor: 2, patch: 3)
        let version2 = VersionNumber(major: 1, minor: 2, patch: 3)

        let version3 = VersionNumber(major: 6, minor: 2, patch: 3)
        let version4 = VersionNumber(major: 1, minor: 0, patch: 3)

        assert(version1) == version2
        assert(version3) != version4
    }

    func test_version_number_comparable() {
        let version1 = VersionNumber(major: 1, minor: 2, patch: 3)
        let version2 = VersionNumber(major: 1, minor: 2, patch: 4)

        let version3 = VersionNumber(major: 6, minor: 2, patch: 3)
        let version4 = VersionNumber(major: 1, minor: 0, patch: 3)

        assert(version1) < version2
        assert(version3) >= version4
    }

    func test_version_number_printable() {
        let version = VersionNumber(major: 1, minor: 2, patch: 3)
        assert(version.string) == "1.2.3"
    }

    func test_string_init_throws_expected_error_on_invalid_version_string() {
        XCTAssertThrowsError(try VersionNumber(from: "1.x.$")) { error in
            guard let versionError = error as? VersionNumber.Error else {
                XCTFail("VersionNumber init threw unexpected error")
                return
            }
            assert(versionError) == .unableToParse("1.x.$")
        }
    }

    func test_string_init_throws_expected_error_on_long_version_string() {
        XCTAssertThrowsError(try VersionNumber(from: "1.2.3.4")) { error in
            guard let versionError = error as? VersionNumber.Error else {
                return fail("VersionNumber init threw unexpected error")
            }
            assert(versionError) == .incompatibleFormat("1.2.3.4")
        }
    }
}
