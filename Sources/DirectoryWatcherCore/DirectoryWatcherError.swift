//
//  DirectoryWatcherError.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation

public enum DirectoryWatcherError: LocalizedError {
    case custom(String)

    public var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        }
    }
}
