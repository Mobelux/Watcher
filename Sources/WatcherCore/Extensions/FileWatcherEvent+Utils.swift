//
//  FileWatcherEvent+Utils.swift
//  Watcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import FileWatcher

extension FileWatcherEvent {
    var fileChanged: Bool {
        fileCreated || fileRemoved || fileRenamed || fileModified
    }

    var dirChanged: Bool {
        dirCreated || dirRemoved || dirRenamed || dirModified
    }
}
