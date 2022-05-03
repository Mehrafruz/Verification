//
//  MaskedImage.swift
//  FaceYoga
//
//  Created by Дмитрий Марченков on 23.03.2021.
//

import UIKit

final class MaskedImageView: UIImageView {
    
    //MARK: - Views
    lazy private var maskedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.image
        return imageView
    }()
    
    //MARK: - Init
    override init(image: UIImage?) {
        super.init(image: image)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        maskedImageView.frame = bounds
        mask = maskedImageView
    }
    
    //MARK: - Methods
    public func setShadows(color: UIColor, offSet: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = color.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = offSet
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
}
