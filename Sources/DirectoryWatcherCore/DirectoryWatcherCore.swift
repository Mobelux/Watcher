//
//  DirectoryWatcherCore.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/22/23.
//

import Files
import FileWatcher
import Foundation

public struct DirectoryWatcherCore {
    public static func watch(
        from folder: Folder = .current
    ) throws -> Task<Void, Error> {

        return makeTask(
            watching: [],
            operation: { _ in })
    }
}

extension DirectoryWatcherCore {
    static func makeTask(
        watching paths: [String],
        debouncedBy nanoseconds: UInt64? = nil,
        operation: @escaping @Sendable (DirectoryEvent) async -> Void
    ) -> Task<Void, Error> {
        .detached {
            do {
                for try await event in FileWatcher.changes(on: paths, debouncedBy: nanoseconds) {
                    await operation(event)
                }
            } catch {
                print("Error: \(error)")
                return
            }
        }
    }
}
