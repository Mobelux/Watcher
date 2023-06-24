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
    private let watchedPath: String
    private let logger: @Sendable (String) -> Void
    private let executor: @Sendable (String) -> Void

    init(
        watchedPath: String,
        logger: @escaping @Sendable (String) -> Void,
        executor: @escaping @Sendable (String) -> Void
    ) {
        self.watchedPath = watchedPath
        self.logger = logger
        self.executor = executor
    }

    func watchCommand(_ configuration: CommandConfiguration) throws -> @Sendable (DirectoryEvent) -> Void {
        let pattern = try Glob.Pattern(configuration.pattern, mode: Constants.globPatternGrouping)
        return { event in
            guard pattern.match(event.path.removingPrefix(watchedPath)) else {
                return
            }

            logger("\(event.path) changed: performing \(configuration.command)")
            executor(configuration.command)
        }
    }
}

extension WatchCommandProvider {
    static func live(
        watching watchedPath: String,
        logger: @escaping @Sendable (String) -> Void = log(_:)
    ) -> Self {
        return WatchCommandProvider(
            watchedPath: watchedPath,
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
