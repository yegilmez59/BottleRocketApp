//
//  UIFontExtension.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import UIKit

extension UIFont {
    static func avenirBold(for fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir Next Demi Bold", size: fontSize)
    }
    
    static func avenirRegular(for fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir Next Regular", size: fontSize)
    }
}
