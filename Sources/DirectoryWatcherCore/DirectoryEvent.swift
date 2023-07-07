//
//  DirectoryEvent.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation

public struct DirectoryEvent: Sendable {
    public let path: String
    public let description: String

    public init(path: String, description: String) {
        self.path = path
        self.description = description
    }
}
