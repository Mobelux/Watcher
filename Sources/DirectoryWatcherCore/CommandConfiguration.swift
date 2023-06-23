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
    let name: String?
}