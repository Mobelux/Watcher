//
//  Configuration.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation

struct CommandConfiguration: Codable, Equatable {
    let pattern: String
    let command: String
    let exclude: String?
    let name: String?

    init(pattern: String, command: String, exclude: String? = nil, name: String? = nil) {
        self.pattern = pattern
        self.command = command
        self.exclude = exclude
        self.name = name
    }
}
