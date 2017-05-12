//
//  TextStyle.swift
//  ThemeKit
//
//  Created by Josh Campion on 07/02/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

// Private String for the RawRepresentable value of `TextStyle`s.

private let Display4Raw = "display4"
private let Display3Raw = "display3"
private let Display2Raw = "display2"
private let Display1Raw = "display1"
private let HeadlineRaw = "headline"
private let TitleRaw = "title"
private let SubHeadlineRaw = "subHeadline"
private let Body1Raw = "body1"
private let Body2Raw = "body2"
private let CaptionRaw = "caption"
private let ButtonRaw = "button"

/**
 
 Enum defining the available fonts types. An app will likely only use a subset of these.
 
 The goal of the `TextStyle` is to ensure fonts used throughout the application are consistent and appropriate for the context they are used in. All `UITableView` and `UICollectionView` cells will likely have the same font styles for titles and details even if they are representing different model objects.
 
 The `TextStyle` also allows different fonts to be trialled in the event of an app design refresh. White labelled apps can each have a unique value for each `TextStyle` but each view in an app can be reused without modification - even those in Storyboards.
 
 The enum cases are taken from the [Google Material Design guidelines for typography](https://www.google.com/design/spec/style/typography.html#typography-styles). For more details on which styles are appropriate in different situations the documentation there is the recommended source.
 
 There may be times when this selection of font styles is not appropriate or sufficient. In these situations the `.Custom(String)` case can be used to specify any `String` not matching one of the other enum cases. This custom `TextStyle` can be referenced from a Storyboard using the `String` value, and in code by defining a global variable:
 
        let myTextStyle = TextStyle.Custom("MyOwnStyle")
 
 */
public enum TextStyle: Hashable, RawRepresentable {
    
    /// The `RawRepresentable` type for `TextStyle`.
    public typealias RawValue = String
    
    // MARK: Cases
    
    /// Display Text Styles: Typically used for large titles, results, or main data labels. Size increase with number i.e.. `Display4` > `Display3`.
    case display4, display3, display2, display1
    
    /// Typically a large font used for page headings.
    case headline
    
    /// Typically a medium sized font used for element titles such as `UITableViewCell` and `UICollectionViewCell` titles.
    case title
    
    /// Typically a medium sized font used to distinguish sub-elements within a page `UITableView` and `UICollectionView` section headings.
    case subHeadline
    
    /// Typically a readable sans serif font.
    case body1
    
    /// Typically a bold or italic veriant of Body1 allowing for text highlights.
    case body2
    
    /// Typically the smallest font, used for `UITabBarItems` and small, ancillary text.
    case caption
    
    /// Typically a font that is similar to `Body1` and `Body2` that is clearly a call to action to help ensure the button stands out as interactable.
    case button
    
    /// A unique style defined by the programmer in circumstances where the default [Google Material Design](https://www.google.com/design/spec/style/typography.html#typography-styles) selection is insufficient.
    case custom(String)
    
    // MARK: Initialisers
    
    /**
     
     Default initialiser.
     
     - parameter rawValue: The string value matching a standard text style. If `rawValue` does not match any of the standard values, `.Custom(rawValue)` is created instead.
     
     */
    public init?(rawValue: String) {
        switch rawValue{
        case Display4Raw:
            self = .display4
        case Display3Raw:
            self = .display3
        case Display2Raw:
            self = .display2
        case Display1Raw:
            self = .display1
        case HeadlineRaw:
            self = .headline
        case TitleRaw:
            self = .title
        case SubHeadlineRaw:
            self = .subHeadline
        case Body1Raw:
            self = .body1
        case Body2Raw:
            self = .body2
        case CaptionRaw:
            self = .caption
        case ButtonRaw:
            self = .button
        default:
            self = .custom(rawValue)
        }
    }
    
    // MARK: Protocol Conformance
    
    /**
     
     `RawRepresentable` protocol conformance.
     
     Returns a String value matching the enum name or the `String` value in `.Custom(String)`.
     
     */
    public var rawValue:String {
        switch self {
        case .display4:
            return Display4Raw
        case .display3:
            return Display3Raw
        case .display2:
            return Display2Raw
        case .display1:
            return Display1Raw
        case .headline:
            return HeadlineRaw
        case .title:
            return TitleRaw
        case .subHeadline:
            return SubHeadlineRaw
        case .body1:
            return Body1Raw
        case .body2:
            return Body2Raw
        case .caption:
            return CaptionRaw
        case .button:
            return ButtonRaw
        case .custom(let str):
            return str
        }
    }
    
    /// `Hashable` protocol conformance. Returns the `hashValue` of the enum's `rawValue`.
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

/// `TextStyle: Equatable` conformance. Equality is determined by the equality of the `rawValue`.
public func ==(t1:TextStyle, t2:TextStyle) -> Bool {
    return t1.hashValue == t2.hashValue
}
