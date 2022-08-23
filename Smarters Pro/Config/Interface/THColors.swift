//
//  THColors.swift
//
//  Created by Sahil Garg on 28/10/20.
//

import UIKit

class THColors {

    static var appHeaderColor : UIColor {
        return UIColor(named: "AppHeaderColor") ?? .white
    }
    
    static var themeColor : UIColor {
        return UIColor(named: "ThemeColor") ?? .white
    }
    
    static var borderThemeColor: UIColor {
        return (UIColor.init(named: "BorderColor") ?? THColors.themeColor) as UIColor
    }
    
    static var labelColor: UIColor {
        return UIColor(named: "LabelColor") ?? .black
    }
    
    static var bgColor: UIColor {
        return UIColor(named: "BGColor") ?? .white
    }
    
    static var yellowBGColor: UIColor {
        return UIColor(named: "YellowButtonBGColor") ?? .white
    }
    
}
