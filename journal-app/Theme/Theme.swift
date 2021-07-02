//
//  ColorPalette.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import Foundation
import UIKit

struct ThemeColor {
    
    static let todayColors = [today1, today2, today3, today4]
    
    // UI colors
    static let background: UIColor = UIColor.white
    static let heading: UIColor = UIColor.darkGray
    static let overlay: UIColor = UIColor.init(white: 1, alpha: 0.50)
    static let subheading: UIColor = UIColor.darkGray.withAlphaComponent(0.70)
    
    // Section/Accent colors
    static let color1: UIColor = UIColor.init(red: 206/240.0, green: 212/240.0, blue: 218/240.0, alpha: 1)
    static let color2: UIColor = UIColor.init(red: 254/240.0, green: 197/240.0, blue: 187/240.0, alpha: 1)
    static let color3: UIColor = UIColor.init(red: 216/240.0, green: 226/240.0, blue: 220/240.0, alpha: 1)
    static let color4: UIColor = UIColor.init(red: 255/240.0, green: 215/240.0, blue: 186/240.0, alpha: 1)
    static let color5: UIColor = UIColor.init(red: 237/240.0, green: 220/240.0, blue: 210/240.0, alpha: 1)
    static let color6: UIColor = UIColor.init(red: 65/240.0, green: 87/240.0, blue: 209/240.0, alpha: 1)
    
    // Today cell gradient colors
    static let today1: UIColor = UIColor.init(red: 177/240.0, green: 175/240.0, blue: 209/240.0, alpha: 1)
    static let today2: UIColor = UIColor.init(red: 168/240.0, green: 157/240.0, blue: 204/240.0, alpha: 1)
    static let today3: UIColor = UIColor.init(red: 153/240.0, green: 133/240.0, blue: 192/240.0, alpha: 1)
    static let today4: UIColor = UIColor.init(red: 127/240.0, green: 110/240.0, blue: 173/240.0, alpha: 1)
}
