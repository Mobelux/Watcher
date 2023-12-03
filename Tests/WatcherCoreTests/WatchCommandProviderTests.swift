//
//  WatchCommandProviderTests.swift
//  Watcher
//
//  Created by Mathew Gacy on 6/24/23.
//

@testable import WatcherCore
import Foundation
import XCTest

final class WatchCommandProviderTests: XCTestCase {
    func testCommandForWatchedFile() throws {
        let (executor, provider) = WatchCommandProvider.mock(watching: Mock.watchedPath)
        let config = Mock.commandConfigurations[0]
        let command = try provider.watchCommand(config)

        command(Mock.matchingSwiftEvent)
        XCTAssertEqual(executor.executedCommands, [config.command])
    }

    func testUnwatchedFileIgnored() throws {
        let (executor, provider) = WatchCommandProvider.mock(watching: Mock.watchedPath)
        let config = Mock.commandConfigurations[0]
        let command = try provider.watchCommand(config)

        command(Mock.notMatchingEvent)
        XCTAssertEqual(executor.executedCommands, [])
    }

    func testExcludedFileIgnored() throws {
        let (executor, provider) = WatchCommandProvider.mock(watching: Mock.watchedPath)
        let config = Mock.commandConfigurations[1]
        let command = try provider.watchCommand(config)

        command(Mock.excludedEvent)
        XCTAssertEqual(executor.executedCommands, [])
    }
}
