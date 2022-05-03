//
//  UISlider+Extensions.swift
//  Highlights
//
//  Created by Мехрафруз on 28.05.2021.
//

import UIKit

extension UISlider { 
    func applyGradientWithPosition(colors: [UIColor],
                       cornerRadius: CGFloat? = nil,
                       position: GradientPosition = .leftToRight) {
        
        if let _ = layer.sublayers?.first as? CAGradientLayer {
            layer.sublayers?.first?.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer.createGradient(colors: colors,
                                                           cornerRadius: cornerRadius == nil ? self.layer.cornerRadius : cornerRadius,
                                                           position: position)
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
