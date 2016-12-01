//
//  BackgroundColourThemeable.swift
//  ThemeKit
//
//  Created by Josh Campion on 07/02/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public protocol BackgroundColourThemeable: Themeable {
    
    var backgroundColourStyle:ColourStyle? { get set }
    var backgroundColourStyleId:String? { get set }
    
    func applyBackgroundTheme(_ theme:Theme)
}

public extension BackgroundColourThemeable where Self:UIView {
    
    public func applyBackgroundTheme(_ theme: Theme) {
        if let bgStyle = backgroundColourStyle {
            backgroundColor = theme.colour(bgStyle)
        }
    }
}
