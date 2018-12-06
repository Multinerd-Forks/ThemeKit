//
//  ThemeConstants.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

// MARK: - Constants

/**
 
 Apple's default system font sizes for comparison to `MaterialTextSizes`.
 
      UIFontTextStyleBody:          17.0
      UIFontTextStyleHeadline:      17.0
      UIFontTextStyleSubheadline:   15.0
      UIFontTextStyleCaption1:      12.0
      UIFontTextStyleCaption2:      11.0
      UIFontTextStyleFootnote:      13.0
 
 */
let AppleFontSizes:[String:CGFloat] = [UIFont.TextStyle.body.rawValue: 17.0,
                                       UIFont.TextStyle.headline.rawValue: 17.0,
                                       UIFont.TextStyle.subheadline.rawValue: 15.0,
                                       UIFont.TextStyle.caption1.rawValue: 12.0,
                                       UIFont.TextStyle.caption2.rawValue: 11.0,
                                       UIFont.TextStyle.footnote.rawValue: 13.0
]

/**
 
 The default text sizes for each text style as defined by [Google Material Design Guidelines](https://www.google.com/design/spec/style/typography.html#typography-styles).
 
 
      .Display4:    112.0
      .Display3:    56.0
      .Display2:    45.0
      .Display1:    34.0
      .Headline:    24.0
      .Title:       20.0
      .SubHeadline: 16.0
      .Body2:       14.0
      .Body1:       14.0
      .Caption:     12.0
      .Button:      14.0
 
 */
public let MaterialTextSizes:[TextStyle:CGFloat] = [
    .display4: 112.0,
    .display3: 56.0,
    .display2: 45.0,
    .display1: 34.0,
    .headline: 24.0,
    .title: 20.0,
    .subHeadline: 16.0,
    .body2: 14.0,
    .body1: 14.0,
    .caption: 12.0,
    .button: 14.0
]

/**
 
 The default font adjustments for each `UIContentSizeCategory` based on the changes in font size for Apple's system font.
 
        .extraSmall:            -3
        .small:                 -2
        .medium:                -1
        .large:                  0
        .extraLarge:             1
        .extraExtraLarge:        2
        .extraExtraExtraLarge:   3
 
 */
public let AppleFontAdjustments:[UIContentSizeCategory:CGFloat] = [
    .extraSmall: -3,
    .small: -2,
    .medium: -1,
    .large: 0,
    .extraLarge: 1,
    .extraExtraLarge: 2,
    .extraExtraExtraLarge: 3,
    //.accessibilityMedium: 4,
    //.accessibilityLarge: 5,
    //.accessibilityExtraLarge: 6,
    //.accessibilityExtraExtraLarge: 7,
    //.accessibilityExtraExtraExtraLarge: 8,
]

/// Enum to define content sizes for accessibility. This allows for exhaustive switch statements over using standard UIKit Strings. Accessibility Sizes are mapped to .ExtraExtraExtraLarge.

public enum TKContentSizeCategory:String {
    
    case extraSmall, small, medium, large, extraLarge, extraExtraLarge, extraExtraExtraLarge
    
    /// Convenience initialiser to create the enum from a UIContentSizeCategory String from UIKit. Fails if the sting is not one of those.
    init?(contentSize:UIContentSizeCategory) {
        switch contentSize {
        case UIContentSizeCategory.extraSmall:
            self = .extraSmall
        case UIContentSizeCategory.small:
            self = .small
        case UIContentSizeCategory.medium:
            self = .medium
        case UIContentSizeCategory.large:
            self = .large
        case UIContentSizeCategory.extraLarge:
            self = .extraLarge
        case UIContentSizeCategory.extraExtraLarge:
            self = .extraExtraLarge
        case UIContentSizeCategory.extraExtraExtraLarge,
        UIContentSizeCategory.accessibilityMedium,
        UIContentSizeCategory.accessibilityLarge,
        UIContentSizeCategory.accessibilityExtraLarge,
        UIContentSizeCategory.accessibilityExtraExtraLarge,
        UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            self = .extraExtraExtraLarge
        default:
            return nil
        }
    }
}

