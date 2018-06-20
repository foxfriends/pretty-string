//
//  PrettyString+Attributes.swift
//  PrettyString
//
//  Created by Cameron Eldridge on 2018-06-20.
//  Copyright © 2018 Cameron Eldridge. All rights reserved.
//

import Foundation
import UIKit

extension PrettyString {
    public enum Attribute {
// The commented out keys are unsupported, but left in for completeness.
//        case accessibilityAlignment
//        case accessibilityAnnotationTextAttribute
//        case accessibilityAttachment
//        case accessibilityAutocorrected
//        case accessibilityBackgroundColor
//        case accessibilityCustomText
//        case accessibilityFont
//        case accessibilityForegroundColor
//        case accessibilityLanguage
//        case accessibilityLink
//        case accessibilityListItemIndex
//        case accessibilityListItemLevel
//        case accessibilityListItemPrefix
//        case accessibilityMarkedMisspelled
//        case accessibilityMisspelled
//        case accessibilityShadow
//        case accessibilityStrikethrough
//        case accessibilityStrikethroughColor
//        case accessibilitySuperscript
//        case accessibilityUnderline
//        case accessibilityUnderlineColor
//        case cursor
//        case glyphInfo(NSGlyphInfo)
//        case markedClauseSegment(Int)
//        case spellingState(Int)
//        case superscript(Int)
//        case textAlternatives(NSTextAlternatives)
//        case toolTip(String)
//        case usesScreenFontsDocumentAttribute
//        case verticalGlyphForm

        case attachment(NSTextAttachment)
        case backgroundColor(UIColor)
        case baselineOffset(Float)
        case expansion(Float)
        case font(UIFont)
        case foregroundColor(UIColor)
        case kern(Float)
        case ligature(Int)
        case link(URL)
        case obliqueness(Float)
        case paragraphStyle(NSParagraphStyle)
        case shadow(NSShadow)
        case strikethroughColor(UIColor)
        case strikethroughStyle(Int)
        case strokeColor(UIColor)
        case strokeWidth(Float)
        case textEffect(String)
        case underlineColor(UIColor)
        case underlineStyle(NSUnderlineStyle)
        case writingDirection([Int])

        func apply(_ attributes: [NSAttributedStringKey: Any]) -> [NSAttributedStringKey: Any] {
            var attributes = attributes
            attributes[self.key] = self.value
            return attributes
        }

        var key: NSAttributedStringKey {
            switch self {
            case .attachment: return NSAttributedStringKey.attachment
            case .backgroundColor: return NSAttributedStringKey.backgroundColor
            case .baselineOffset: return NSAttributedStringKey.baselineOffset
            case .expansion: return NSAttributedStringKey.expansion
            case .font: return NSAttributedStringKey.font
            case .foregroundColor: return NSAttributedStringKey.foregroundColor
            case .kern: return NSAttributedStringKey.kern
            case .ligature: return NSAttributedStringKey.ligature
            case .link: return NSAttributedStringKey.link
            case .obliqueness: return NSAttributedStringKey.obliqueness
            case .paragraphStyle: return NSAttributedStringKey.paragraphStyle
            case .shadow: return NSAttributedStringKey.shadow
            case .strikethroughColor: return NSAttributedStringKey.strikethroughColor
            case .strikethroughStyle: return NSAttributedStringKey.strikethroughStyle
            case .strokeColor: return NSAttributedStringKey.strokeColor
            case .strokeWidth: return NSAttributedStringKey.strokeWidth
            case .textEffect: return NSAttributedStringKey.textEffect
            case .underlineColor: return NSAttributedStringKey.underlineColor
            case .underlineStyle: return NSAttributedStringKey.underlineStyle
            case .writingDirection: return NSAttributedStringKey.writingDirection
            }
        }

        var value: Any {
            switch self {
            case .attachment(let attachment): return attachment
            case .backgroundColor(let color): return color
            case .baselineOffset(let offset): return NSNumber(value: offset)
            case .expansion(let expansion): return NSNumber(value: expansion)
            case .font(let font): return font
            case .foregroundColor(let color): return color
            case .kern(let kern): return NSNumber(value: kern)
            case .ligature(let ligature): return NSNumber(value: ligature)
            case .link(let url): return url
            case .obliqueness(let obliqueness): return NSNumber(value: obliqueness)
            case .paragraphStyle(let style): return style
            case .shadow(let shadow): return shadow
            case .strikethroughColor(let color): return color
            case .strikethroughStyle(let style): return NSNumber(value: style)
            case .strokeColor(let color): return color
            case .strokeWidth(let width): return NSNumber(value: width)
            case .textEffect(let effect): return effect
            case .underlineColor(let color): return color
            case .underlineStyle(let style): return style
            case .writingDirection(let directions): return directions
            }
        }
    }
}
