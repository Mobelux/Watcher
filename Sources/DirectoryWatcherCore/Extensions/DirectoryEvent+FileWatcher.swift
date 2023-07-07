//
//  DirectoryEvent+FileWatcher.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 7/6/23.
//

#if canImport(FileWatcher)
import FileWatcher
import Foundation

extension DirectoryEvent {
    init?(_ fileWatcherEvent: FileWatcherEvent) {
        guard fileWatcherEvent.dirChanged || fileWatcherEvent.fileChanged else {
            return nil
        }

        self.path = fileWatcherEvent.path
        self.description = fileWatcherEvent.description
    }
}
#endif
