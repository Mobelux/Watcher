//
//  DirectoryWatcherError.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation

/// Errors thrown by DirectoryWatcher.
public enum DirectoryWatcherError: LocalizedError {
    /// An error with a custom description.
    case custom(String)

    public var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        }
    }
}
