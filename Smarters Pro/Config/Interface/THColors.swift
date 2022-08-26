//
//  THColors.swift
//
//  Created by Sahil Garg on 28/10/20.
//

import UIKit

class THColors {

    static var themeColor : UIColor {
        return UIColor(named: "ThemeColor") ?? .white
    }
    
    static var borderThemeColor: UIColor {
        return (UIColor.init(named: "BorderColor") ?? THColors.themeColor) as UIColor
    }
    
}
