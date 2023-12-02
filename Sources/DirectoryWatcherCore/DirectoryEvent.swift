//
//  DirectoryEvent.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import FileWatcher
import Foundation

/// An event that occurred in a directory being watched.
public struct DirectoryEvent: Sendable {
    /// The path to the directory that was changed.
    public let path: String
    /// A description of the event.
    public let description: String

    /// Initialize a new `DirectoryEvent`.
    ///
    /// - Parameters:
    ///   - path: The path to the directory that was changed.
    ///   - description: A description of the event.
    public init(path: String, description: String) {
        self.path = path
        self.description = description
    }
}

extension DirectoryEvent {
    /// Initialize a new `DirectoryEvent` from a `FileWatcherEvent`.
    ///
    /// - Parameter fileWatcherEvent: The `FileWatcherEvent` to use.
    init?(_ fileWatcherEvent: FileWatcherEvent) {
        guard fileWatcherEvent.dirChanged || fileWatcherEvent.fileChanged else {
            return nil
        }

        self.path = fileWatcherEvent.path
        self.description = fileWatcherEvent.description
    }
}
