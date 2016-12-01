//
//  TKTabBar.swift
//  ThemeKit
//
//  Created by Josh Campion on 12/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

open class TKTabBar: UITabBar, BarThemeable {
    
     
    
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
    
    
    open var tintColourStyle:ColourStyle?  {
        didSet {
            checkAndUpdateColourStyle(oldValue, tintColourStyle)
        }
    }
    
    open var barTintColourStyle:ColourStyle?  {
        didSet {
            checkAndUpdateColourStyle(oldValue, barTintColourStyle)
        }
    }
    
    // MARK: Inspectable Properties
    
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
    
    open var barTintColourStyleId:String? {
        set {
            if let idString = newValue,
                let style = ColourStyle(rawValue:idString) {
                barTintColourStyle = style
            }
        }
        get {
            return barTintColourStyle?.rawValue
        }
    }

    // Theme Functions
    
    open func applyTheme(_ theme:Theme) {
        
        applyProtocolThemes(theme)
        
        if let tabItems = self.items {
            for item in tabItems {
                if let themedItem = item as? Themeable {
                    themedItem.applyTheme(theme)
                }
            }
        }
    }
}
