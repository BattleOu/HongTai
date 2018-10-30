//
//  UIColor-Extension.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/24.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat) {
        
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ a : CGFloat) {
        
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
}
