//
//  EditButton.swift
//  Highlights
//
//  Created by Мехрафруз on 06.05.2021.
//

import UIKit

final class MainButton: UIButton {
    
    //MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.applyShadow(shadowOffSet: CGSize(width: 0, height: 0), shadowOpacity: 12, shadowRadius: 12, color: ColorsPalette.PreviewHighlight.buttonShadow.getColor().withAlphaComponent(0.18))
        self.applyGradient(colors: [
            ColorsPalette.PreviewHighlight.buttonColorLeftGrad.getColor(),
            ColorsPalette.PreviewHighlight.buttonColorRightGrad.getColor()
        ])
        
    }
    
    //MARK: - Methods
    func setupView(text: String) {
        self.setTitle(text, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
        self.backgroundColor = UIColor(red: 246 / 255, green: 247 / 255, blue: 252 / 255, alpha: 1.0)
        self.titleLabel?.font = R.font.rubikMedium(size: 18)
        self.setTitleColor(.white, for: .normal)
    }
}
