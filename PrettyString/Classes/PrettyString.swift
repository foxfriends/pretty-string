//
//  PrettyString.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation

public struct PrettyString {
    public let raw: String
    public let config: Config

    public init(_ string: String, config: Config = .default) {
        self.raw = string
        self.config = config
    }

    public func parse() throws -> NSAttributedString {
        return try PrettyString.parse(raw, config: config)
    }

    public var text: String {
        return raw
    }
}
