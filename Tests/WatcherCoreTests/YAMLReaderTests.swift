//
//  YAMLReaderTests.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/24/23.
//

@testable import WatcherCore
import Foundation
import XCTest

final class YAMLReaderTests: XCTest {
    let configURL = URL(fileURLWithPath: "\(Mock.commandConfigurations)\(".watcher.yml")")

    func testReadValidConfig() throws {
        var readURL: URL?
        let sut = YAMLReader(read: { url in
            readURL = url
            return Mock.configYAML
        })

        let actual: [CommandConfiguration]? = try sut.read(at: configURL)

        XCTAssertEqual(actual, Mock.commandConfigurations)
        XCTAssertEqual(readURL, configURL)
    }

    func testReadInvalidValidConfig() throws {
        let sut = YAMLReader(read: { _ in "foo" })
        XCTAssertThrowsError({
            let config: [CommandConfiguration]? = try sut.read(at: self.configURL)
            _ = config
        })
    }
}
