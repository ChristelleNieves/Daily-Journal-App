//
//  ColorPalette.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import Foundation
import UIKit

struct ThemeColor {
    
    //static let peach: UIColor = UIColor.init(red: 247/240.0, green: 235/240.0, blue: 223/240.0, alpha: 1)
    
    // UI colors
    static let background: UIColor = UIColor.white
    static let heading: UIColor = UIColor.darkGray
    static let overlay: UIColor = UIColor.init(white: 1, alpha: 0.50)
    static let subheading: UIColor = UIColor.darkGray.withAlphaComponent(0.70)
    
    // Section/Accent colors
    static let robinEggBlue: UIColor = UIColor.init(red: 164/240.0, green: 217/240.0, blue: 206/240.0, alpha: 1)
    //static let robinEggBlue: UIColor = UIColor.init(red: 120/240.0, green: 95/240.0, blue: 248/240.0, alpha: 1)
    static let salmonPink: UIColor = UIColor.init(red: 255/240.0, green: 154/240.0, blue: 162/240.0, alpha: 1)
    static let peachPuff: UIColor = UIColor.init(red: 255/240.0, green: 212/240.0, blue: 184/240.0, alpha: 1)
    static let lilac: UIColor = UIColor.init(red: 201/240.0, green:162/240.0, blue: 202/240.0, alpha: 1)
    
}
