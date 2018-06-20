//
//  PrettyString+Parse.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation

private enum State {
    case start
    case open(String)
    case doubleOpen
    case close
    case openClose
}

private enum Token {
    case open(String)
    case close
    case text(String)
}

private func lmm(_ text: String, _ state: State = .start) throws -> (Token, String) {
    let (first, rest) = (text.first.map(String.init), String(text.dropFirst()))
    switch (state, first) {
    case (.start, .some("{")):                  return try lmm(rest, .open(""))
    case (.start, .some("}")):                  return try lmm(rest, .close)
    case (.start, .some(let char)):             return (.text(char), rest)
    case (.open(""), .some("{")):               return try lmm(rest, .doubleOpen)
    case (.open(""), .some("}")):               return try lmm(rest, .openClose)
    case (.open(""), .some(":")):               throw PrettyString.Error.missingName
    case (.open(let name), .some(":")):         return (.open(name), rest)
    case (.open(let name), .some(let char)):    return try lmm(rest, .open(name + char))
    case (.close, _):                           return (.close, text)
    case (.doubleOpen, _):                      return (.text("{"), text)
    case (.openClose, _):                     return (.text("}"), text)
    default: throw PrettyString.Error.incompleteToken
    }
}

private func tokenize(_ string: String) throws -> [Token] {
    var string = string
    var tokens: [Token] = []
    while !string.isEmpty {
        let (token, rest) = try lmm(string)
        tokens.append(token)
        string = rest
    }
    return tokens
}

private func compile(_ attributes: [[PrettyString.Attribute]]) -> [NSAttributedStringKey: Any] {
    return attributes
        .reduce([:], { compiled, set in
            set.reduce(compiled, { $1.apply($0) })
        })
}

extension PrettyString {
    /// Parses the string using the PrettyString format, generating an attributed string by applying the attributes
    /// defined in the Config
    public static func parse(_ string: String, config: Config = .default) throws -> NSAttributedString {
        let tokens = try tokenize(string)

        let attributedString = NSMutableAttributedString(string: "")
        var segment = ""
        var attributes: [[Attribute]] = [config.base]

        for token in tokens {
            switch token {
            case .text(let char):
                segment += char
            case .open(let name):
                if !segment.isEmpty {
                    attributedString.append(NSAttributedString(string: segment, attributes: compile(attributes)))
                    segment = ""
                }
                guard let rule = config.rules.first(where: { $0.name == name }) else {
                    throw PrettyString.Error.undefinedName
                }
                attributes.append(rule.attributes)
            case .close:
                if !segment.isEmpty {
                    attributedString.append(NSAttributedString(string: segment, attributes: compile(attributes)))
                    segment = ""
                }
                guard attributes.count > 1 else {
                    throw PrettyString.Error.unclosedAnnotation
                }
                attributes.removeLast()
            }
        }

        if !segment.isEmpty {
            attributedString.append(NSAttributedString(string: segment, attributes: compile(attributes)))
        }

        guard attributes.count == 1 else {
            throw PrettyString.Error.unclosedAnnotation
        }

        return NSAttributedString(attributedString: attributedString)
    }
}
