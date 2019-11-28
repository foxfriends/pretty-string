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
  /// An attribute supported by PrettyString. Each corresponds directly to the same `NSAttributedString.Key`.
  /// See the `NSAttributedString` documentation for information on each of these attributes.
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

    func apply(_ attributes: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
      var attributes = attributes
      attributes[self.key] = self.value
      return attributes
    }

    var key: NSAttributedString.Key {
      switch self {
      case .attachment: return NSAttributedString.Key.attachment
      case .backgroundColor: return NSAttributedString.Key.backgroundColor
      case .baselineOffset: return NSAttributedString.Key.baselineOffset
      case .expansion: return NSAttributedString.Key.expansion
      case .font: return NSAttributedString.Key.font
      case .foregroundColor: return NSAttributedString.Key.foregroundColor
      case .kern: return NSAttributedString.Key.kern
      case .ligature: return NSAttributedString.Key.ligature
      case .link: return NSAttributedString.Key.link
      case .obliqueness: return NSAttributedString.Key.obliqueness
      case .paragraphStyle: return NSAttributedString.Key.paragraphStyle
      case .shadow: return NSAttributedString.Key.shadow
      case .strikethroughColor: return NSAttributedString.Key.strikethroughColor
      case .strikethroughStyle: return NSAttributedString.Key.strikethroughStyle
      case .strokeColor: return NSAttributedString.Key.strokeColor
      case .strokeWidth: return NSAttributedString.Key.strokeWidth
      case .textEffect: return NSAttributedString.Key.textEffect
      case .underlineColor: return NSAttributedString.Key.underlineColor
      case .underlineStyle: return NSAttributedString.Key.underlineStyle
      case .writingDirection: return NSAttributedString.Key.writingDirection
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
