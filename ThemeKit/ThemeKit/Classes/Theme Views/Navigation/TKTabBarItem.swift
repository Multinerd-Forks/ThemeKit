//
//  TKTabBarItem.swift
//  ThemeKit
//
//  Created by Josh Campion on 31/01/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

@IBDesignable
open class TKTabBarItem: UITabBarItem, TextThemeable {
    
     
    
    // - initWithFrame(_:) support
    open var createdFromNib:Bool = false
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        createdFromNib = true
    }
    
    // MARK: Themeable
    
    open func theme() -> Theme? {
        return TKThemeVendor.shared().defaultTheme
    }
    
    fileprivate var _needsUpdateTheme:Bool = true
    
    open func setNeedsUpdateTheme() {
        _needsUpdateTheme = true
    }
    
    open func updateThemeIfNeeded() {
        
    }
    
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
    
    // MARK: Inspectable Properties
    
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
