//
//  Tools.swift
//  MijnWords
//
//  Created by Juan Daniel on 30/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
