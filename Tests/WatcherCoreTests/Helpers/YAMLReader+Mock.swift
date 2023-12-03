//
//  YAMLReader+Mock.swift
//  Watcher
//
//  Created by Mathew Gacy on 7/6/23.
//

@testable import WatcherCore
import Foundation

extension YAMLReader {
    static var mock: Self {
        .init(read: { _ in
            Mock.configYAML
        })
    }
}
