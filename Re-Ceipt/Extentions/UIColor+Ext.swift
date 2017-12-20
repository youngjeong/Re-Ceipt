//
//  UIColor+Ext.swift
//  Re-Ceipt
//
//  Created by 유영정 on 2017. 12. 20..
//  Copyright © 2017년 SSU. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0) }
}
