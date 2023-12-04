//
//  WatchCommandProvider+Mock.swift
//  Watcher
//
//  Created by Mathew Gacy on 7/6/23.
//

@testable import WatcherCore
import Foundation

final class CommandExecutor: @unchecked Sendable {
    var executedCommands: [String] = []

    func execute(_ command: String) {
        executedCommands.append(command)
    }
}

extension WatchCommandProvider {
    static func mock(watching watchedPath: String) -> (CommandExecutor, Self) {
        let executor = CommandExecutor()
        let commandProvider = WatchCommandProvider(watchedPath: watchedPath, logger: { _ in }) {
            executor.execute($0)
        }

        return (executor, commandProvider)
    }
}
