//
//  WatchCommandProvider.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation
import GlobPattern
import ShellOut

struct WatchCommandProvider {
    private let logger: @Sendable (String) -> Void
    private let executor: @Sendable (String) -> Void

    func watchCommand(_ configuration: CommandConfiguration) throws -> @Sendable (DirectoryEvent) -> Void {
        let pattern = try Glob.Pattern(configuration.pattern, mode: Constants.globPatternGrouping)
        return { event in
            guard pattern.match(event.path) else {
                return
            }

            logger("\(event.path) changed: performing \(configuration.command)")
            executor(configuration.command)
        }
    }
}

extension WatchCommandProvider {
    static func live(logger: @escaping @Sendable (String) -> Void = log(_:)) -> Self {
        return WatchCommandProvider(
            logger: logger,
            executor: { command in
                do {
                    try shellOut(
                        to: command,
                        outputHandle: FileHandle.standardOutput,
                        errorHandle: FileHandle.standardError
                    )
                } catch {
                    logger("ERROR: \(error)")
                }
            })
    }
}
