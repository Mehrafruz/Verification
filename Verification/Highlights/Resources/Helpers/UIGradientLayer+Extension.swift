//
//  UIGradientLayer+Extension.swift
//  Highlights
//
//  Created by Дмитрий Марченков on 07.04.2021.
//

import UIKit

enum GradientPosition {
    case topToBottom
    case leftToRight
    case topLeftToBottomRight
    case topRightToBottomLeft
}

extension UIView {
    func applyGradient(colors: [UIColor],
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

extension CAGradientLayer {
    static func createGradient(colors: [UIColor],
                               cornerRadius: CGFloat? = nil,
                               position: GradientPosition = .leftToRight) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        
        switch position {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        gradientLayer.cornerRadius = cornerRadius ?? 0
        return gradientLayer
    }
    
}
