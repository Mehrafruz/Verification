//
//  CustomTabBarItem.swift
//  Verification
//
//  Created by Мехрафруз on 16.04.2021.
//

import UIKit

final class CustomTabBarItem: UIView {
    
    //MARK: - Properties
    public var tapAction: ((CustomTabBarItem)->())?
    private var isSmallDevice = UIDevice().isSmallDevice
    
    private let selectedImage: UIImage
    private let unselectedImage: UIImage
    
    //MARK: - Views
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    //MARK: - Init
    init(selectedImage: UIImage, unselectedImage: UIImage, labelName: String) {
        self.selectedImage = selectedImage
        self.unselectedImage = unselectedImage
        self.titleLabel.text = labelName
        super.init(frame: CGRect())
        addGestures()
        addConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //---Gestures
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(gestureAction))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func gestureAction() {
        tapAction?(self)
    }
    
    public func setNeededState(isSelected: Bool) {
        let titleColor = isSelected ? UIColor.black : UIColor.gray
        let neededImage = isSelected ? selectedImage : unselectedImage
        
        UIView.AnimationTransition.transitionChangeTextColor(label: titleLabel, color: titleColor)
        UIView.AnimationTransition.transitionChangeImageInImageView(imageView: iconImageView, image: neededImage)
    }
    
    //---Layout
    private func addConstraints() {
        addSubview(titleLabel)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                               constant: isSmallDevice ? -5 : 0),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 26),
            iconImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5)
        ])
    }
    
}
