//
//  TKSwitch.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

@IBDesignable
open class TKSwitch:UISwitch, Themeable, ThumbTintColourThemeable {
    
     
    
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
    
    // MARK: - Properties
    
    
    // MARK: - Theme Properties
    
    open var thumbTintColourStyle:ColourStyle?  {
        didSet {
            checkAndUpdateColourStyle(oldValue, thumbTintColourStyle)
        }
    }
    
    open var onTintColourStyle:ColourStyle?  {
        didSet {
            if oldValue != onTintColourStyle {
                setNeedsUpdateTheme()
            }
        }
    }
    
    // MARK: Inspectable Properties
    
    open var thumbTintColourStyleId:String? {
        set {
            if let idString = newValue,
                let style = ColourStyle(rawValue: idString) {
                thumbTintColourStyle = style
            }
        }
        get {
            return thumbTintColourStyle?.rawValue
        }
    }
    
    open var onTintColourId:String? {
        set {
            if let idString = newValue,
                let style = ColourStyle(rawValue: idString) {
                onTintColourStyle = style
            }
        }
        get {
            return onTintColourStyle?.rawValue
        }
    }

    
    // MARK: Theme Functions
    
    open func applyTheme(_ theme: Theme) {
        
        applyProtocolThemes(theme)
        
        if let style = onTintColourStyle {
                onTintColor = theme.colour(style)
        }
    }
    
    
}
