//
//  UIView.AnimationTransition+Extension.swift
//  Highlights
//
//  Created by Дмитрий Марченков on 07.04.2021.
//

import UIKit

extension UIView.AnimationTransition {
    static func transitionChangeText(label: UILabel, text: String) {
        UIView.transition(with: label,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { label.text = text},
                          completion: nil)
    }
    
    static func transitionChangeTextColor(label: UILabel, color: UIColor, duration: Double? = nil) {
        UIView.transition(with: label,
                          duration: duration == nil ? 0.3 : duration ?? 0.3,
                          options: .transitionCrossDissolve,
                          animations: { label.textColor = color},
                          completion: nil)
    }
    
    static func transitionChangeAttributedText(label: UILabel, attributedText: NSAttributedString) {
        UIView.transition(with: label,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { label.attributedText = attributedText},
                          completion: nil)
    }
    
    static func transitionChangeButtonTitle(button: UIButton, title: String) {
        UIView.transition(with: button,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { button.setTitle(title, for: .normal) },
                          completion: nil)
    }
    
    static func transitionChangeButtonTitle(button: UIButton, title: String, duration: Double) {
        UIView.transition(with: button,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { button.setTitle(title, for: .normal) },
                          completion: nil)
    }
    
    static func transitionChangeButtonImage(button: UIButton, image: UIImage?, duration: Double) {
        UIView.transition(with: button,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { button.setImage(image, for: .normal) },
                          completion: nil)
    }
    
    static func transitionChangeBackgroundColor(view: UIView, color: UIColor, duration: Double = 0.3) {
        UIView.transition(with: view,
                          duration: duration,
                          options: .curveEaseInOut,
                          animations: { view.backgroundColor = color },
                          completion: nil)
    }
    
    static func transitionChangeImageInImageView(imageView: UIImageView, image: UIImage, duration: Double = 0.3) {
        UIView.transition(with: imageView,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { imageView.image = image },
                          completion: nil)
    }
    
    static func transitionChangeIsHiddenView(view: UIView, isHidden: Bool, duration: Double = 0.3) {
        let alpha: CGFloat = isHidden ? 0 : 1
        if !isHidden {
            view.alpha = 1
        }
        UIView.transition(with: view, duration: duration,
                          options: .transitionCrossDissolve,
                          animations: {
                            if isHidden {
                                view.alpha = alpha
                            } else {
                                view.isHidden = isHidden
                            }
                          },
                          completion: {_ in
                            view.isHidden = isHidden
                          })
    }
    /// Stretches itself to the size of the view, including the Safe Area
}


