//
//  PrettyString+Error.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

extension PrettyString {
    public enum Error: Swift.Error {
        case incompleteToken
        case missingName
        case undefinedName
        case unclosedAnnotation
    }
}
