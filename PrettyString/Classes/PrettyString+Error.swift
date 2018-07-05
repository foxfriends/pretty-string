//
//  PrettyString+Error.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

extension PrettyString {
    /// An error that can occur while parsing the raw text. These errors are intended to provide some hint as to what
    /// is going wrong when debugging, but in practice can generally be ignored.
    public enum Error: Swift.Error {
        /// The string ended while trying to find a name (`"Hello {blu"` would cause this error)
        case incompleteToken
        /// It looks like a name should have been written, but no name was found (`"Hello {:world}"` would cause this error)
        case missingName
        /// A name was found but there is no corresponding rule for it.
        case undefinedName
        /// The opening `{` and closing `}` do not match up (`"Hello {blue: world"` would cause this error)
        case unclosedAnnotation
    }
}
