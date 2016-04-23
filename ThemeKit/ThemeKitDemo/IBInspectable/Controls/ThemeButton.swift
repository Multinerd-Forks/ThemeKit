//
//  ThemeButton.swift
//  ThemeKit
//
//  Created by Josh Campion on 07/02/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit
import ThemeKitCore

@IBDesignable
public class ThemeButton: TKButton, IBThemeable {
    
    @IBInspectable
    override public var backgroundColourStyleId:String? { didSet { } }
    
    @IBInspectable
    override public var tintColourStyleId:String? { didSet { } }
    
    @IBInspectable
    override public var textStyleId:String? { didSet { } }
    
    @IBInspectable
    override public var textColourStyleId:String? { didSet { } }
}