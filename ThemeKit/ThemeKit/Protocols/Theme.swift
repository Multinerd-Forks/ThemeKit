//
//  Theme.swift
//  ThemeKit
//
//  Created by Josh Campion on 06/07/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

/// Type specificatoin used only when Theme can specify types for TextStyle and ColourStyle. Currently this results in in a generic UILabel which can't be included in a Storyboard.
public typealias RawRepresentableKey = RawRepresentable & Hashable

public protocol Theme {
    
    var defaultTextSizes:[TextStyle:CGFloat] { get }
    var textSizeAdjustments:[UIContentSizeCategory:CGFloat] { get }
    
    var themeColours:[ColourStyle:UIColor] { get }
    
    init()
    
    /**

    Returns the font name for a given text style, which is used in UIFont(name:size:).
    
    To ensure good consistent design, only a few font faces should be specified for a theme, and text styles should be variants of those font faces. Due to the number of text styles vs the number of font names, this can be more succinctly expressed as a switch than a dictionary.

    - seealso: MaterialTheme
    */
    func fontName(_ textStyle:TextStyle) -> String
    
    func font(_ textStyle:TextStyle, sizeCategory:UIContentSizeCategory?) -> UIFont

    func colour(_ colourStyle:ColourStyle) -> UIColor
}

public extension Theme {
    
    final func fontSize(_ textStyle:TextStyle, sizeCategory:UIContentSizeCategory) -> CGFloat {
        
        var fontSize:CGFloat
        if let size = defaultTextSizes[textStyle] {
            fontSize = size
        } else {
            TKLogError(self, function: #function, message: "No text size specified for text style \(textStyle.rawValue). Using defualt 17.0.")
            fontSize = 17.0
        }
        
        if let adjustment = textSizeAdjustments[sizeCategory] {
                fontSize += adjustment
        }
        
        return fontSize
    }
    
    public func currentContentSizeCategory() -> UIContentSizeCategory {
        
        let preferredContentSize = UIApplication.shared.preferredContentSizeCategory
        if TKContentSizeCategory(contentSize: preferredContentSize) != nil {
            return preferredContentSize
        } else {
            TKLogError(self, function: #function, message: "Unknown current content size category: \(preferredContentSize) ")
            return .large
        }
    }
    
    
    public func font(_ textStyle:TextStyle, sizeCategory:UIContentSizeCategory? = UIContentSizeCategory.medium) -> UIFont {
        
        let size = fontSize(textStyle, sizeCategory: sizeCategory ?? currentContentSizeCategory())
        
        guard let font = UIFont(name: fontName(textStyle), size: size) else {
            TKLogError(self, function: #function, message: "No font specified for text style \(textStyle.rawValue). Using system font.")
            return UIFont.systemFont(ofSize: size)
        }
        
        return font
    }
    
    public func colour(_ colourStyle:ColourStyle) -> UIColor {

        guard let colour = themeColours[colourStyle] else {
            TKLogError(self, function: #function, message: "No colour specified for colour style \(colourStyle.rawValue). Using default Black.")
            return UIColor.black
        }
        
        return colour
    }
}
