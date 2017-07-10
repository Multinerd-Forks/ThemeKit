//
//  TKTextField.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

let TKDefaultInsets = UIEdgeInsetsMake(2.0, 7.0, 2.0, 7.0)

@IBDesignable
open class TKTextField: UITextField, BackgroundColourThemeable, TintColourThemeable, TextThemeable {
    
     
    
    // - initWithFrame(_:) support
    open var createdFromNib:Bool = false

    open var placeholderRect: CGRect = .zero
    
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
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        updateThemeIfNeeded()
        
        // TODO: This should be .Fill if there is no text and the placholderTextStyle != nil but .Center otherwise. There is still a bug when editting but no text is typed, so the placeholder is still visible
        
        if let text = self.text, !text.isEmpty {
            contentVerticalAlignment = .center
        } else {
            contentVerticalAlignment = .fill
        }
    }
    
    // --
    
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
    
    open var textStyle:TextStyle? {
        didSet {
            checkAndUpdateTextStyle(oldValue, textStyle)
        }
    }
    
    open var textColourStyle:ColourStyle?  {
        didSet {
            checkAndUpdateColourStyle(oldValue, textColourStyle)
        }
    }
    
    fileprivate var _placeholderTextStyle:TextStyle?
    
    /// This can be set explicitly to configure the style of the placeholder text, otherwise it defaults to the textStyle property.
    open var placeholderTextStyle:TextStyle? {
        get {
            return _placeholderTextStyle ?? textStyle
        }
        set {
            _placeholderTextStyle = newValue
            if placeholderTextStyle != newValue {
                setNeedsUpdateTheme()
            }
        }
    }
    
    open var placeholderTextColourStyle:ColourStyle?  {
        didSet {
            if oldValue != placeholderTextColourStyle {
                setNeedsUpdateTheme()
            }
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

    open var placeholderTextStyleId:String? {
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
    
    open var placeholderTextColourStyleId:String? {
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
    
    // MARK: Text Field Methods
    
    /// can set to nil to return to set textInsets to the default value but will always return a value
    @IBInspectable open var textInsetsString:String? {
        get {
            return "{\(textInsets.top),\(textInsets.left),\(textInsets.bottom),\(textInsets.right)}"
        } set {
            if let insetsString = newValue {
                textInsets =  UIEdgeInsetsFromString(insetsString)
            }
        }
    }
    
    override open var intrinsicContentSize : CGSize {
        
//        print("sizing: \(self)")
        
        let superSize = super.intrinsicContentSize
//        print("super: \(superSize)")
        
        if let theme = theme(),
            let myFont = font {
                // If font is not set, it is the default font so super.intrinsicContentSize() will be correct
                let text:NSString = self.text as NSString? ?? "Testing Text"
                let textHeight = text.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                    attributes: [NSFontAttributeName: myFont],
                    context: nil).size.height
                var height = textHeight
                
//                print("\(text): \(textHeight)")
                
                let attributedPlaceholder:NSAttributedString?
                if let setPlaceholder = self.attributedPlaceholder {
                    attributedPlaceholder = setPlaceholder
                } else if let placeholderStyle = placeholderTextStyle {
                    attributedPlaceholder = NSAttributedString(string: "Testing Placeholder", attributes: [NSFontAttributeName: theme.font(placeholderStyle)])
                } else {
                    attributedPlaceholder = nil
                }
                
                if let attributed = attributedPlaceholder {
                    
                    // only consider the placeholder if there is an attributed placeholder, as this will be from the text style applied for the theme
                    let placeholderHeight = attributed.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                        context: nil).size.height
                    
//                    print("\(attributed.string): \(placeholderHeight)")
                    
                    height = max(placeholderHeight, height)
                }
                
//                print("insets: \(textInsetsString)")
                
                // ensure the insets are met
                height += textInsets.top + textInsets.bottom
                
//                print("height:\(height)")
                
                // don't let this become smaller than the default as other views won't fit correctly
                height = max(superSize.height, height)
                
                return CGSize(width: superSize.width, height: height)
        }
        
        return superSize
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        // let superRect = super.textRectForBounds(bounds)
        
        let leftRect = leftViewRect(forBounds: bounds)
        let rightRect = rightViewRect(forBounds: bounds)
        
        var newBounds = bounds
        // inset the bounds based on the left and right views (this is for search bar support)
        newBounds.origin.x += leftRect.origin.x + leftRect.size.width
        newBounds.size.width -= leftRect.origin.x + leftRect.size.width + (bounds.maxX - rightRect.origin.x)
        
        // inset the bounds based on the text insets property.
        newBounds.origin.x += textInsets.left
        newBounds.origin.y += textInsets.top
        newBounds.size.width -= textInsets.left + textInsets.right
        newBounds.size.height -= textInsets.top + textInsets.bottom
        
//        print("\(text)/\(attributedPlaceholder): \(superRect) -> \(newBounds)")
        
        return newBounds
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        // let superRect = super.placeholderRectForBounds(bounds)
        let textRect = self.textRect(forBounds: bounds)
        
//        print("placeholder: \(superRect) -> \(textRect)")
        
        self.placeholderRect = CGRect(x: textRect.origin.x, y: (textRect.size.height - self.font!.lineHeight)/1.6, width: textRect.size.width, height: self.font!.lineHeight)

        return self.placeholderRect
    }

    override open func caretRect(for position: UITextPosition) -> CGRect {

        let rect = super.caretRect(for: position)

        return CGRect(x: rect.origin.x, y: self.placeholderRect.origin.y, width: rect.size.width, height: self.font!.lineHeight/1.2)
        
    }
    
    open var textInsets:UIEdgeInsets = TKDefaultInsets  {
        didSet {
            if !UIEdgeInsetsEqualToEdgeInsets(textInsets, oldValue) {
                invalidateIntrinsicContentSize()
                setNeedsLayout()
            }
        }
    }
    
    override open var placeholder: String? {
        didSet {
            if let theme = theme() {
                updatePlaceholder(theme)
            }
        }
    }

    open func applyTheme(_ theme: Theme) {
        applyProtocolThemes(theme)
        
        updatePlaceholder(theme)
    }
    
    func updatePlaceholder(_ theme:Theme) {
        if let attributedPlaceholder = self.attributedPlaceholder ?? (placeholder != nil ? NSAttributedString(string: placeholder!) : nil) {
            
            // confiure the placeholder
            
            var attributes = attributedPlaceholder.attributes(at: 0, effectiveRange: nil)
            
            if let placeholderStyle = self.placeholderTextStyle {
                attributes[NSFontAttributeName] = theme.font(placeholderStyle)
            }
            
            if let placeholderColourStyle = self.placeholderTextColourStyle {
                attributes[NSForegroundColorAttributeName] = theme.colour(placeholderColourStyle)
            }
            
            // Set new text with extracted attributes
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
}
