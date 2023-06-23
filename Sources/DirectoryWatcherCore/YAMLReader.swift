//
//  YAMLReader.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation
import Yams

public struct YAMLReader {
    private let decoder: YAMLDecoder = .init()
    private let read: (URL) throws -> String

    public init(read: @escaping (URL) throws -> String) {
        self.read = read
    }

    public func read<T: Decodable>(at url: URL) throws -> T? {
        do {
            return try decoder.decode(
                T.self,
                from: try read(url))
        } catch CocoaError.Code.fileReadNoSuchFile {
            return nil
        }
    }
}

public extension YAMLReader {
    static var live: Self {
        .init(read: { try String(contentsOf: $0) })
    }
}
