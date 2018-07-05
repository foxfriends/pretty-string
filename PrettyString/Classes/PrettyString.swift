//
//  PrettyString.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation

/// The base PrettyString object. This struct is used to generate the NSAttributedString based on the provided
/// PrettyString and its config.
public struct PrettyString {
    /// The raw plain text, with annotations included
    public let raw: String
    /// The config that will be used to format this string
    public let config: Config

    /// Creates a PrettyString
    ///
    /// - Parameter string: The string, including PrettyString markup
    /// - Parameter config: The config used to format the string
    public init(_ string: String, config: Config = .default) {
        self.raw = string
        self.config = config
    }

    /// Parses the string using the PrettyString format, generating an attributed string by applying the attributes
    /// defined in the Config
    ///
    /// - Parameter string: The string to parse, with PrettyString markup included
    /// - Parameter config: The config to use to parse this string
    /// - Throws: A `PrettyString.Error` that describes what went wrong
    /// - Returns: The attributed string
    public func parse() throws -> NSAttributedString {
        return try PrettyString.parse(raw, config: config)
    }

    /// The plain text of this string, as if it were parsed with the given config. If it cannot be parsed, this
    /// string is the same as the raw string.
    public var text: String {
        return (try? parse().string) ?? raw
    }
}
