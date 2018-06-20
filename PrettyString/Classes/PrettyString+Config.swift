//
//  PrettyString+Config.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation

extension PrettyString {
    public struct Config {
        public struct Rule {
            /// The name of this style, which can be specified in the string
            public let name: String
            /// The attributes that are applied to the text when the name is found
            public let attributes: [Attribute]

            public init(name: String, attributes: [Attribute]) {
                self.name = name
                self.attributes = attributes
            }
        }

        /// Default config with no rules
        public static var `default`: Config = Config(base: [], rules: [])

        /// The attributes applied to the unmarked text.
        public let base: [Attribute]
        /// Rules specifying how to handle each marking within the text.
        public let rules: [Rule]

        public init(base: [Attribute] = [], rules: [Rule] = []) {
            self.base = base
            self.rules = rules
        }
    }
}
