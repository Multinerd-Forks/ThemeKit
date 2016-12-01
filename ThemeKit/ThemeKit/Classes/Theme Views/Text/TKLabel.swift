//
//  TKLabel.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

open class TKLabel: UILabel, BackgroundColourThemeable, TintColourThemeable, TextThemeable {
    
     
    
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
    
    // MARK:- Theme Properties
    
    open var textStyle:TextStyle?  {
        didSet {
            checkAndUpdateTextStyle(oldValue, textStyle)
        }
    }
    
    open var textColourStyle:ColourStyle?  {
        didSet {
            checkAndUpdateColourStyle(oldValue, textColourStyle)
        }
    }
    
    open var backgroundColourStyle:ColourStyle? {
        didSet {
            checkAndUpdateColourStyle(oldValue, backgroundColourStyle)
        }
    }
    
    open var tintColourStyle:ColourStyle? {
        didSet {
            checkAndUpdateColourStyle(oldValue, tintColourStyle)
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

}
