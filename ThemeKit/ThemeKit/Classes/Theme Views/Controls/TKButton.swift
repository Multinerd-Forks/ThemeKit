//
//  TKButton.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

@IBDesignable
open class TKButton: UIButton, Themeable, TintColourThemeable, BackgroundColourThemeable, TextThemeable {
    
     
    
    // - initWithFrame(_:) support
    open var createdFromNib:Bool = false
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        createdFromNib = true
    }
    
     open override func didMoveToSuperview() {
            super.didMoveToSuperview()
        
        if let theme = theme(), !createdFromNib {
            applyTheme(theme)
        }
    }
    
    // --
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        updateThemeIfNeeded()
    }
    
    // MARK: - Themeable Properties
    
    open var backgroundColourStyle:ColourStyle?  {
        didSet {
            checkAndUpdateColourStyle(oldValue, backgroundColourStyle)
        }
    }
    
    open var tintColourStyle:ColourStyle?  {
        didSet {
            checkAndUpdateColourStyle(oldValue, tintColourStyle)
        }
    }
    
    open var textStyle:TextStyle?  {
        didSet {
            checkAndUpdateTextStyle(oldValue, textStyle)
        }
    }
    
    open var textColourStyle: ColourStyle? {
        didSet {
            checkAndUpdateColourStyle(oldValue, textColourStyle)
        }
    }
    
    // MARK: Inspectable Properties
    
    open var backgroundColourStyleId:String? {
        get {
            return backgroundColourStyle?.rawValue
        }
        set {
            if let rawValue = newValue,
                let style = ColourStyle(rawValue: rawValue) {
                backgroundColourStyle = style
            } else {
                backgroundColourStyle = nil
            }
        }
    }

    open var tintColourStyleId:String? {
        get {
            return tintColourStyle?.rawValue
        }
        set {
            if let rawValue = newValue,
                let style = ColourStyle(rawValue: rawValue) {
                tintColourStyle = style
            } else {
                tintColourStyle = nil
            }
        }
    }

    
    open var textStyleId:String? {
        set {
            if let idString = newValue,
                let style = TextStyle(rawValue:idString) {
                textStyle = style
            }
        }
        get {
            return textStyle?.rawValue
        }
    }
    
    open var textColourStyleId:String? {
        set {
            if let idString = newValue,
                let style = ColourStyle(rawValue:idString) {
                textColourStyle = style
            }
        }
        get {
            return textColourStyle?.rawValue
        }
    }
    
    // MARK: - Themeable Functions
    
    open func applyTextTheme(_ theme: Theme) {
        
        if let text = textStyle {
            titleLabel?.font = theme.font(text)
        }
        
        if let colour = textColourStyle {
            titleLabel?.textColor = theme.colour(colour)
        }
    }
}
