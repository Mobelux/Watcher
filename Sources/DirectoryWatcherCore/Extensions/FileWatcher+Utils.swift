//
//  FileWatcher+Utils.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import FileWatcher
import Foundation

// Based on: https://github.com/JohnSundell/Publish/pull/138
public extension FileWatcher {
    static func changes(
        on paths: [String],
        debouncedBy nanoseconds: UInt64?
    ) -> AsyncThrowingStream<DirectoryEvent, Error> {
        .init { continuation in
            var deferredTask: Task<Void, Error>?

            let watcher = FileWatcher(paths)
            watcher.callback = { watcherEvent in
                guard let event = DirectoryEvent(watcherEvent) else {
                    return
                }

                guard let nanoseconds else {
                    continuation.yield(event)
                    return
                }

                deferredTask?.cancel()

                deferredTask = Task {
                    do {
                        try await Task.sleep(nanoseconds: nanoseconds)
                        continuation.yield(event)
                    } catch where !(error is CancellationError) {
                        continuation.finish()
                    }
                }
            }

            watcher.start()

            continuation.onTermination = { _ in
                watcher.stop()
            }
        }
    }
}
