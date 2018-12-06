//
//  TitleTextThemeable.swift
//  ThemeKit
//
//  Created by Josh Campion on 07/02/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Defines a protocol for objects that set text attributes such as font and colour through an optoinal dictionary of type `[String: AnyObject]` for multiple `UIControlState`s. This includes `UITabBarItem` and `UIBarButtonItem`. This allows protocol extensions to add functionality to multiple UIKit classes.
public protocol StateTitleTextAttributes {

    /**
     
     Getter for the title attributes in a given `UIControlState`.
     
     - parameter state: The control state to get the title text attributes for.
     
     - returns: The attributes for the title in the given state.
    */
    func titleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key : Any]?
    
    /**
     
     Setter for the title attributes in a given `UIControlState`.
     
     - parameter attributes: The attributes for the title in the given state.
     - parameter state: The control state to set the title text attributes for.
     
     */
    func setTitleTextAttributes(_ attributes: [NSAttributedString.Key : Any]?, for state: UIControl.State)
}

/// Defines a protocol for objects that set text attributes such as font and colour through an optoinal dictionary of type `[NSObject: AnyObject]` for multiple `UIControlState`s. This includes `UISegmentedControl`. This allows protocol extensions to add functionality to multiple UIKit classes.
public protocol StateObjectTitleTextAttributes {
    
    /**

     Getter for the title attributes in a given `UIControlState`.

     - parameter state: The control state to get the title text attributes for.

     - returns: The attributes for the title in the given state.
     */
    func titleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key : Any]?

    /**

     Setter for the title attributes in a given `UIControlState`.

     - parameter attributes: The attributes for the title in the given state.
     - parameter state: The control state to set the title text attributes for.

     */
    func setTitleTextAttributes(_ attributes: [NSAttributedString.Key : Any]?, for state: UIControl.State)
    
}

/// Protocol conformance to allow protocol extensions to give conformane to ThemeKit protocols.
extension UISegmentedControl: StateObjectTitleTextAttributes { }

/// Protocol conformance to allow protocol extensions to give conformane to ThemeKit protocols.
extension UITabBarItem: StateTitleTextAttributes { }

/// Protocol conformance to allow protocol extensions to give conformane to ThemeKit protocols.
extension UIBarButtonItem: StateTitleTextAttributes { }

public extension TextThemeable where Self: StateTitleTextAttributes {
    
    /// Applies the font and text colour for `UIControlState.Normal` from the given theme using `setTitleTextAttributes(_:forState:)`
    public func applyTextTheme(_ theme: Theme) {
        
        // theme the state dependent title text attributes
        var attributes = self.titleTextAttributes(for: UIControl.State()) ?? [NSAttributedString.Key:Any]()
        
        if let style = textStyle {
            attributes[.font] = theme.font(style)
        }
    
        if let style = textColourStyle {
            attributes[.foregroundColor] = theme.colour(style)
        }
        
        setTitleTextAttributes(attributes, for: UIControl.State())
    }
    
}

public extension TextThemeable where Self: StateObjectTitleTextAttributes {
    
    /// Applies the font and text colour for `UIControlState.Normal` from the given theme using `setTitleTextAttributes(_:forState:)`
    public func applyTextTheme(_ theme: Theme) {
        
        // theme the state dependent title text attributes
        var attributes = self.titleTextAttributes(for: UIControl.State()) ?? [NSAttributedString.Key: Any]()
        
        if let style = textStyle {
            attributes[.font] = theme.font(style)
        }
        
        if let style = textColourStyle {
            attributes[.foregroundColor] = theme.colour(style)
        }
        
        setTitleTextAttributes(attributes, for: UIControl.State())
    }
    
}
