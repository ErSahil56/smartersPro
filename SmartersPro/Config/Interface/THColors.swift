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
    
    static var userSelectedColor: UIColor {
        return (UIColor.init(named: "UserSelectedColor") ?? THColors.themeColor) as UIColor
    }
    
    static var buttonColor: UIColor {
        return (UIColor.init(named: "ButtonColor") ?? THColors.themeColor) as UIColor
    }
    
    static var themeBackGroundColor: UIColor {
        return "#2D3C68".hexStringToUIColor()
    }
    
}
