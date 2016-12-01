//
//  TKSlider.swift
//  ThemeKit
//
//  Created by Josh Campion on 07/02/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

open class TKSlider: UISlider, ThumbTintColourThemeable {
    
     
    
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
    
    // MARK: - Theme Properties
    
    open var thumbTintColourStyle:ColourStyle? {
        didSet {
            checkAndUpdateColourStyle(oldValue, thumbTintColourStyle)
        }
    }
    
    // MARK: Custom Theme Properties
    
    open var minimumTrackTintColourStyle:ColourStyle? {
        didSet {
            checkAndUpdateColourStyle(oldValue, minimumTrackTintColourStyle)
        }
    }
    
    open var maximumTrackTintColourStyle:ColourStyle? {
        didSet {
            checkAndUpdateColourStyle(oldValue, minimumTrackTintColourStyle)
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
    
    open var minimumTrackTintColourStyleId:String? {
        set {
            if let idString = newValue,
                let style = ColourStyle(rawValue: idString) {
                minimumTrackTintColourStyle = style
            }
        }
        get {
            return minimumTrackTintColourStyle?.rawValue
        }
    }
    
    open var maximumTrackTintColourStyleId:String? {
        set {
            if let idString = newValue,
                let style = ColourStyle(rawValue: idString) {
                maximumTrackTintColourStyle = style
            }
        }
        get {
            return maximumTrackTintColourStyle?.rawValue
        }
    }

    
    // MARK: Custom Apply Theme
    
    open func applyTheme(_ theme: Theme) {
        
        applyProtocolThemes(theme)
        
        if let style = minimumTrackTintColourStyle {
            minimumTrackTintColor = theme.colour(style)
        }
        
        if let style = maximumTrackTintColourStyle {
            maximumTrackTintColor = theme.colour(style)
        }
    }
}
