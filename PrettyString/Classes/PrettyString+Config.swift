//
//  PrettyString+Config.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation

extension PrettyString {
    /// Defines the attributes that are to be applied to the text
    public struct Config {
        /// Defines a name to be recognized by the parser, and the attributes to be applied when that name is
        /// encountered
        public struct Rule {
            /// The name of this style, which can be specified in the string
            public let name: String
            /// The attributes that are applied to the text when the name is found
            public let attributes: [Attribute]

            /// Creates a new Rule
            ///
            /// - Parameter name: The name that will be used for this rule
            /// - Parameter attributes: An array of `Attribute`s that will be applied to matching text
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

        /// Creates a new config
        ///
        /// - Parameter base: The `Attribute`s to be applied to the base text
        /// - Parameter rules: The `Rule`s that can be used in the string
        public init(base: [Attribute] = [], rules: [Rule] = []) {
            self.base = base
            self.rules = rules
        }
    }
}
