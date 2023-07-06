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
        let watchPatttern = try Glob.Pattern(configuration.pattern, mode: Constants.globPatternGrouping)
        let excludePattern = try configuration.exclude
            .flatMap { try Glob.Pattern($0, mode: Constants.globPatternGrouping) }
        let commandDescription = configuration.name ?? "`\(configuration.command)`"

        return { event in
            let relativePath = event.path.removingPrefix(watchedPath)
            guard watchPatttern.match(relativePath), !(excludePattern?.match(relativePath) ?? false) else {
                return
            }

            logger("∆: \(relativePath) - Performing: \(commandDescription)")
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
                        at: watchedPath,
                        outputHandle: FileHandle.standardOutput,
                        errorHandle: FileHandle.standardError
                    )
                } catch {
                    logger("ERROR: \(error)")
                }
            })
    }
}
