//
//  WatcherError.swift
//  Watcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation

/// Errors thrown by Watcher.
public enum WatcherError: LocalizedError {
    /// An error with a custom description.
    case custom(String)

    public var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        }
    }
}
