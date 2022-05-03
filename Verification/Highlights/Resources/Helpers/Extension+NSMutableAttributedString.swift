//
//  Extension + NSMutableAttributedString.swift
//  Taro
//
//  Created by Мехрафруз on 10.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {

    func setColor(color: UIColor, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    
    
}
