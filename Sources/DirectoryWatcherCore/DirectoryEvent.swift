//
//  DirectoryEvent.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import FileWatcher
import Foundation

public struct DirectoryEvent: Sendable {
    let url: URL

    public init(_ fileWatcherEvent: FileWatcherEvent) {
        self.url = URL(fileURLWithPath: fileWatcherEvent.path)
    }
}
