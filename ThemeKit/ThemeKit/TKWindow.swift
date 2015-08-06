//
//  TKWindow.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

public class TKThemeVendor: NSObject {
    
    public static var _internalSharedVendor:TKThemeVendor?
    
    public class func sharedVendor() -> TKThemeVendor {
        return _internalSharedVendor ?? TKThemeVendor()
    }
    
    public func defaultTheme() -> Theme? {
        
        return nil
    }
}

/*
public class TKWindow: UIWindow {

    public class func themeType() -> Theme.Type? {
        return nil
    }
    
    private static var _theme:Theme?
    
    public static var theme:Theme? {
        get {
            if _theme == nil {
                _theme = self.themeType()?.init()
            }
            
            return _theme
        } set {
            _theme = newValue
        }
    }
}
*/