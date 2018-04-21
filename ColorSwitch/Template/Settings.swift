//
//  Settings.swift
//  ColorSwitch
//
//  Created by Anthony Da Cruz on 10/03/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none:UInt32 = 0 //to avoid dynamic type to be just "Int"
    static let ballCategory: UInt32 = 0x1           // 01
    static let switchCategory: UInt32 = 0x1 << 1    // 10
}

enum ZPositions {
    static let label:CGFloat = 0
    static let ball:CGFloat = 1
    static let colorCircle:CGFloat = 2
}

enum GameColors {
    static let generalBackgroundColor: UIColor = UIColor(r: 44, g: 62, b: 80)
    static let scoreFontColor: UIColor = UIColor(r: 255, g: 255, b: 255, a: 0.5)
}
