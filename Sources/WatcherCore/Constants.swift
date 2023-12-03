//
//  Constants.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation
import GlobPattern

enum Constants {
    static let throttleInterval: Int = 1
    static let defaultConfigurationPath: String = ".watcher.yml"
    static let globPatternGrouping: Glob.Mode = .grouping
}
