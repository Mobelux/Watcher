//
//  YAMLReader.swift
//  Watcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import Foundation
import Yams

/// A type that can read a YAML file.
public struct YAMLReader {
    private let decoder: YAMLDecoder = .init()
    private let read: (URL) throws -> String

    /// Initialize a new `YAMLReader`.
    ///
    /// - Parameter read: A closure that reads a file at the given URL and returns its contents.
    /// as a `String`.
    public init(read: @escaping (URL) throws -> String) {
        self.read = read
    }

    /// Returns the decoded contents of the file at the specified URL.
    ///
    /// - Parameter url: The `URL` of the file to read.
    /// - Returns: The decoded contents of the file.
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
    /// The live implementation of the reader.
    static var live: Self {
        .init(read: { try String(contentsOf: $0) })
    }
}
