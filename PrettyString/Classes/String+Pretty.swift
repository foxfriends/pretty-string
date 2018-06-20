//
//  String+Pretty.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation

extension String {
    /// prettifies
    public func prettify(_ config: PrettyString.Config = .default) throws -> NSAttributedString {
        return try PrettyString(self, config: config).parse()
    }
}
