//
//  UIView + Extensions.swift
//  Highlights
//
//  Created by Дмитрий Марченков on 07.04.2021.
//

import UIKit

extension UIView {
    func animateShow() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
    }
    
    func animateHide() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        }
    }
}

extension UIButton {
    static func createNavBarButton(size: CGFloat, image: UIImage?) -> UIButton {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: size).isActive = true
        button.heightAnchor.constraint(equalToConstant: size).isActive = true
        button.setImage(image, for: .normal)
        return button
    }
}

//MARK: - Shadows
extension UIView {
    func applyShadow(shadowOffSet: CGSize = CGSize(width: 0, height: 0), shadowOpacity: Float = 12, shadowRadius: CGFloat = 12, color: UIColor = ColorsPalette.PreviewHighlight.buttonShadow.getColor().withAlphaComponent(0.18)) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}


extension UIView {
  func animateBorderColor(toColor: UIColor, duration: Double) {
    let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
    animation.fromValue = layer.borderColor
    animation.toValue = toColor.cgColor
    animation.duration = duration
    layer.add(animation, forKey: "borderColor")
    layer.borderColor = toColor.cgColor
  }
}
