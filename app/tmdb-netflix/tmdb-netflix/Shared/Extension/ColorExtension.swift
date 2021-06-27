//
//  ColorExtension.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    @nonobjc class var whiteSmoke: UIColor {
        return UIColor(hexString: "#f2f2f2")
    }
    
    @nonobjc class var blueyGrey: UIColor {
        return UIColor(hexString: "#afb0c8")
    }
    
    @nonobjc class var freeSpeechRed: UIColor {
        return UIColor(hexString: "#db0000")
    }
    
    @nonobjc class var matterhorn: UIColor {
        return UIColor(hexString: "#564d4d")
    }
    
    @nonobjc class var darkRed: UIColor {
        return UIColor(hexString: "#831010")
    }
}
