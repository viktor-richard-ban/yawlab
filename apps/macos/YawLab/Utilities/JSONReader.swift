//
//  JSONReader.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 28..
//

import Foundation

/// A generic JSON reader that decodes any `Decodable` type from:
/// - the app bundle
/// - a file URL
 final class JSONReader {

    /// Errors that can occur while loading or decoding JSON.
     enum ReaderError: Error, LocalizedError {
        case resourceNotFound(resource: String, ext: String, bundleID: String?)
        case dataReadFailed(url: URL, underlying: Error)
        case decodeFailed(type: Any.Type, underlying: Error)

         var errorDescription: String? {
            switch self {
            case let .resourceNotFound(resource, ext, bundleID):
                let bundleInfo = bundleID.map { " (bundle: \($0))" } ?? ""
                return "JSON resource not found: \(resource).\(ext)\(bundleInfo)"
            case let .dataReadFailed(url, underlying):
                return "Failed to read JSON data from \(url.path): \(underlying.localizedDescription)"
            case let .decodeFailed(type, underlying):
                return "Failed to decode JSON into \(type): \(underlying.localizedDescription)"
            }
        }
    }

    private let decoder: JSONDecoder

    /// Create a reader with a configurable `JSONDecoder`.
    /// - Parameter decoder: Decoder used for decoding JSON into `Decodable` types.
     init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    /// Load and decode a JSON resource from a bundle.
    ///
    /// - Parameters:
    ///   - type: The `Decodable` type to decode.
    ///   - resource: Resource name without extension.
    ///   - ext: File extension (default: "json").
    ///   - bundle: Bundle to load from (default: `.main`).
    /// - Returns: Decoded instance of `T`.
     func loadFromBundle<T: Decodable>(
        _ type: T.Type,
        resource: String,
        ext: String = "json",
        bundle: Bundle = .main
    ) throws -> T {
        guard let url = bundle.url(forResource: resource, withExtension: ext) else {
            throw ReaderError.resourceNotFound(
                resource: resource,
                ext: ext,
                bundleID: bundle.bundleIdentifier
            )
        }
        return try loadFromURL(type, url: url)
    }

    /// Load and decode JSON from a URL.
    ///
    /// - Parameters:
    ///   - type: The `Decodable` type to decode.
    ///   - url: URL pointing to the JSON file.
    /// - Returns: Decoded instance of `T`.
     func loadFromURL<T: Decodable>(
        _ type: T.Type,
        url: URL
    ) throws -> T {
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            throw ReaderError.dataReadFailed(url: url, underlying: error)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ReaderError.decodeFailed(type: T.self, underlying: error)
        }
    }
}
