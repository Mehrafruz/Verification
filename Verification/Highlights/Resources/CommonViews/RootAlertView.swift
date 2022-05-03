//
//  BaseAlertView.swift
//  Highlights
//
//  Created by Мехрафруз on 20.05.2021.
//

import UIKit

class RootAlertView: UIView {
    
    //MARK: - Public Properties
    public var hideOffSet: CGFloat?
    public var swipeDownAction: (() -> Void)?
    
    //MARK: - Private Properties
    
    private var contentViewCenterYConstraint = NSLayoutConstraint()
    
    private let hidePopUpConst: CGFloat = {
        let initialScreenBounds = UIScreen.main.bounds
        return (initialScreenBounds.height * 0.5) + (initialScreenBounds.width * 0.75) * 0.5
    }()
    
    private let widthMultiply: CGFloat
    private let heightMultiply: CGFloat
    private var isFirstDraw = true
    
    //MARK: - Views
    
    //---ContentView
    public let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.alpha = 0.0
        return view
    }()
    
    //MARK: - Init
    init(
        widthMultiply: CGFloat,
        heightMultiply: CGFloat,
        hideOffSet: CGFloat? = nil
    ){
        self.widthMultiply = widthMultiply
        self.heightMultiply = heightMultiply
        self.hideOffSet = hideOffSet
        super.init(frame: CGRect())
        setConstraints()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard isFirstDraw == true else { return }
        contentView.layer.cornerRadius = contentView.frame.width * 0.115
        contentView.applyShadow(
            shadowOffSet: CGSize(width: 0.0, height: 5.0),
            shadowOpacity: 0.5,
            shadowRadius: 15.0,
            color: .black
        )
        isFirstDraw = false
    }
    
    //MARK: - Private Methods
    
    private func setupGestures() {
        let downSwipeGesture = UISwipeGestureRecognizer()
        downSwipeGesture.direction = .down
        downSwipeGesture.addTarget(self, action: #selector(swipeAction))
        addGestureRecognizer(downSwipeGesture)
    }
    
    @objc private func swipeAction() {
        swipeDownAction?()
    }
    
    //---Layout
    private func setConstraints() {
        addSubview(backgroundView)
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        //---ContentView
        contentViewCenterYConstraint = contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: hidePopUpConst)
        NSLayoutConstraint.activate([
            contentViewCenterYConstraint,
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultiply),
            contentView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: heightMultiply)
        ])
    }
    
    //---Animate stuff
    public func animateShowView() {
        contentViewCenterYConstraint.constant = 0
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.76, initialSpringVelocity: 2.5, options: .curveEaseInOut) {
            self.layoutIfNeeded()
            self.backgroundView.alpha = 1.0
        }
    }
    
    public func animateHideView(completion: @escaping ()->()) {
        contentViewCenterYConstraint.constant = hidePopUpConst + (hideOffSet ?? 0.0)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut) {
            self.layoutIfNeeded()
            self.backgroundView.alpha = 0.0
        } completion: { (_) in
            completion()
        }
    }
    
    
}
