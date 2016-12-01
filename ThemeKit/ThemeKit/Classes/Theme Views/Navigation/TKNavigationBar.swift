//
//  TKNavigationBar.swift
//  ThemeKit
//
//  Created by Josh Campion on 12/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

open class TKNavigationBar: UINavigationBar, BarThemeable, TextThemeable {
    
     
    
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
    
    open var tintColourStyle:ColourStyle? {
        didSet {
            checkAndUpdateColourStyle(oldValue, tintColourStyle)
        }
    }
    
    /// Styles the font for this `UINavigationBar`'s `titleTextAttributes`.
    open var textStyle:TextStyle?  {
        didSet {
            checkAndUpdateTextStyle(oldValue, textStyle)
        }
    }
    
    /// Styles the font colour for this `UINavigationBar`'s `titleTextAttributes`.
    open var textColourStyle:ColourStyle?  {
        didSet {
            if oldValue != textColourStyle {
                setNeedsUpdateTheme()
            }
        }
    }
    
    /// Styles this `UINavigationBar`'s `barTintColor`.
    open var barTintColourStyle:ColourStyle?  {
        didSet {
            if oldValue != barTintColourStyle {
                setNeedsUpdateTheme()
            }
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


    // MARK: Theme Functions
    
    open func applyTextTheme(_ theme: Theme) {
        // apply the title text attributes
        var attributes = self.titleTextAttributes ?? [String:AnyObject]()
        
        if let text = textStyle {
            attributes[NSFontAttributeName] = theme.font(text)
        }
        
        if let textColour = textColourStyle {
            attributes[NSForegroundColorAttributeName] = theme.colour(textColour)
        }
        
        titleTextAttributes = attributes
    }
    
    open func applyTheme(_ theme:Theme) {
        
        applyProtocolThemes(theme)
        
        // apply the theme to the navigation items colours
        if let navItems = self.items {
            for item in navItems {
                
                var allBarItems = [UIBarButtonItem]()
                
                if let left = item.leftBarButtonItems {
                    allBarItems += left
                }

                if let left = item.leftBarButtonItem {
                    allBarItems.append(left)
                }
                
                if let right = item.rightBarButtonItems {
                    allBarItems += right
                }
                
                if let right = item.rightBarButtonItem {
                    allBarItems.append(right)
                }
                
                for barItem in allBarItems {
                    if let themedItem = barItem as? Themeable {
                        themedItem.applyTheme(theme)
                    }
                }
            }
        }
    }
}
