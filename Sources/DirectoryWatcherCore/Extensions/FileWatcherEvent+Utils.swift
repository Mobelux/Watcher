//
//  FileWatcherEvent+Utils.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

#if canImport(FileWatcher)
import FileWatcher

extension FileWatcherEvent {
    var fileChanged: Bool {
        fileCreated || fileRemoved || fileRenamed || fileModified
    }

    var dirChanged: Bool {
        dirCreated || dirRemoved || dirRenamed || dirModified
    }
}
#endif
