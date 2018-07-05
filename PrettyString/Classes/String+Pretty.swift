//
//  String+Pretty.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation

extension String {
    /// Prettifies the string in much the same way that `PrettyString.parse` would
    ///
    /// - Parameter config: The config to use to style this string;
    /// - Returns: The attributed string
    /// - Throws: A `PrettyString.Error` that describes what went wrong
    public func prettify(_ config: PrettyString.Config = .default) throws -> NSAttributedString {
        return try PrettyString(self, config: config).parse()
    }
}
