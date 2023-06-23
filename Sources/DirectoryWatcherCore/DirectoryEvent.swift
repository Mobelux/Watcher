//
//  DirectoryEvent.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import FileWatcher
import Foundation

public struct DirectoryEvent: Sendable {
    let path: String
    let description: String

    public init(_ fileWatcherEvent: FileWatcherEvent) {
        self.path = fileWatcherEvent.path
        self.description = fileWatcherEvent.description
    }
}
