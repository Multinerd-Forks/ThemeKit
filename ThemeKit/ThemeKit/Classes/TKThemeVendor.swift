//
//  TKWindow.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

/**

 Global accessor for a single shared `Theme` to be used throughout the application.
 
 Each element in `ThemeKit` queries this shared instance for its theme. To specify a given `Theme` as the default `Theme`, users should subclass `TKThemeVendor` and override the `defaultTheme` variable. That subclass should be then be referenced before any view code is loaded. The simplest way to do this is to extend `TKThemeVendor` and override the `initialize()` func as given in `MyTheme.swift` template file.
*/
open class TKThemeVendor: NSSingleton {
    
    /// The `Theme` that each `Themeable` component should style itself against.
    open var defaultTheme:Theme?
    
    /**
     
     Convenience accessor for the default font for a given `TextStyle`.
     
     - returns: Returns the result `font(_:sizeCategory:)` on the `defaultTheme` of the `shared() TKThemeVendor`.
    */
    open static func defaultFont(_ textStyle:TextStyle, sizeCategory:UIContentSizeCategory? = UIContentSizeCategory.medium) -> UIFont? {
      
        return TKThemeVendor.shared().defaultTheme?.font(textStyle, sizeCategory: sizeCategory)
    }
    
    /**
     
     Convenience accessor for the default colour for a given `ColourStyle`.
     
     - returns: Returns the result `colour(_:)` on the `defaultTheme` of the `shared() TKThemeVendor`.
     */
    open static func defaultColour(_ colourStyle:ColourStyle) -> UIColor? {
        return TKThemeVendor.shared().defaultTheme?.colour(colourStyle)
    }
}
