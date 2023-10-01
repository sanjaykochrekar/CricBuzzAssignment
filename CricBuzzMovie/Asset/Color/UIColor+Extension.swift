//
//  UIColor+Extension.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit


extension UIColor {
    
    static func appColor(_ color: CBColor, opacity: Double = 1.0) -> UIColor {
        let color:UIColor = UIColor(named: color.rawValue) ?? .clear
        return color.withAlphaComponent(opacity)
    }
    
}


