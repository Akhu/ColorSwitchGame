//
//  Extensions.swift
//  ColorSwitch
//
//  Created by Anthony Da Cruz on 10/03/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension SKScene {
    static let topNotchHeight:CGFloat = 30
}

extension SKLabelNode {
    convenience init(text: String, font: String, fontSize: CGFloat, color: UIColor, position: CGPoint){
        self.init(text: text)
        self.fontSize = fontSize
        self.fontName = font
        self.color = color
        self.position = position
    }
}

extension UIColor {
    
    /// EZSE: init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// EZSE: init method with hex string and alpha(default: 1)
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
}

}
