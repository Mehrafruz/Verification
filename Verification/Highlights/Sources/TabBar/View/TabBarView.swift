//
//  TabBarView.swift
//  Verification
//
//  Created by Мехрафруз on 09.04.2021.
//

import UIKit

protocol TabBarViewDelegate: AnyObject {
    func addNewButtonAction()
}

final class TabBarView {
    
    //MARK: - Properties
    private var tabBarViewTopConstraint = NSLayoutConstraint()
    private var buttonTopConstraint = NSLayoutConstraint()
    
    weak private var delegate: TabBarViewDelegate?
    
    private var isLayerSet = false
    private var tabBarHeight: CGFloat = 0.0
    private var buttonSize = UIScreen.main.bounds.width * 0.13
    
    private var isSmallDevice = UIDevice().isSmallDevice
    
    private var buttonTopInset: CGFloat {
        switch isSmallDevice {
        case true:
            return -20.0
        case false:
            return -15.0
        }
    }
    
    //MARK: - Views
    private let tabBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorsPalette.GeneralColors.tabBarColor.getColor()
        return view
    }()
    
    lazy public var allTabBarItems: [CustomTabBarItem] = [leftTabBarItem, rightTabBarItem]
    
    private let leftTabBarItem = CustomTabBarItem(selectedImage: R.image.starSelectIcon() ?? .init(),
                                                  unselectedImage: R.image.starDeselectIcon() ?? .init(), labelName: "США")
    private let rightTabBarItem = CustomTabBarItem(selectedImage: R.image.starSelectIcon() ?? .init(),
                                                   unselectedImage: R.image.starDeselectIcon() ?? .init(), labelName: "ФРГ")
    
    private let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorsPalette.GeneralColors.tabBarColor.getColor()
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "E5E5E5")
        return view
    }()
    
    lazy private var addNewHighlightButton: UIButton = {
        let button = UIButton()
        let buttonInset = buttonSize / 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setImage(R.image.addButtonImage(), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: buttonInset, left: buttonInset, bottom: buttonInset, right: buttonInset)
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        return button
    }()
    
    //MARK: - Init
    init(subscriber: TabBarViewDelegate) {
        self.delegate = subscriber
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    //---Buttons actions
    private func setupButtons() {
        addNewHighlightButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func buttonAction(sender: UIButton) {
        switch sender {
        case addNewHighlightButton:
            delegate?.addNewButtonAction()
        default:
            break
        }
    }
    
    public func checkTabBarSelected(completion: @escaping (Int)->()) {
        for item in allTabBarItems {
            item.tapAction = { [weak self] selectedItem in
                guard let self = self else { return }
                for (index, item) in self.allTabBarItems.enumerated() {
                    if item == selectedItem {
                        completion(index)
                        item.setNeededState(isSelected: true)
                    } else {
                        item.setNeededState(isSelected: false)
                    }
                }
            }
        }
    }
    
    public func setNeededItem() {
        for item in allTabBarItems {
            item.setNeededState(isSelected: item == leftTabBarItem)
        }
    }
    
    public func animateShowCollectionView(view: UIView) {
        tabBarViewTopConstraint.constant = UIScreen.main.bounds.height - tabBarHeight
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 2.5, options: .curveEaseInOut) {
            view.layoutIfNeeded()
        }
        
        self.animateShowButton(view: view)
    }
    
    public func animateHideCollectionView(view: UIView) {
        tabBarViewTopConstraint.constant = UIScreen.main.bounds.height - buttonTopInset
        buttonTopConstraint.constant = +tabBarHeight + 58
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
            view.layoutIfNeeded()
        }
    }
    
    public func animateShowButton(view: UIView) {
        addNewHighlightButton.alpha = 0.0
        buttonTopConstraint.constant = buttonTopInset
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 2.5, options: .curveEaseInOut) {
            self.addNewHighlightButton.alpha = 1.0
            view.layoutIfNeeded()
        }
    }
    
    //---Layout
    public func setLayers() {
        guard isLayerSet == false else { return }
        isLayerSet = true
        addNewHighlightButton.layer.cornerRadius = addNewHighlightButton.frame.height / 2
        addNewHighlightButton.applyGradient(colors: [UIColor(hexString: "6FC3B9"),
                                                     UIColor(hexString: "64F29B")],
                                            position: .topToBottom)
        
        addNewHighlightButton.applyShadow(shadowOffSet: CGSize(width: 0, height: 5),
                                          shadowOpacity: 10.0,
                                          shadowRadius: 10.0,
                                          color: UIColor.black.withAlphaComponent(0.3))
    }
    
    public func setConstraints(view: UIView, tabBarHeight: CGFloat) {
        
        view.addSubview(tabBarView)
        view.addSubview(emptyView)
        tabBarView.addSubview(leftTabBarItem)
        tabBarView.addSubview(rightTabBarItem)
        view.addSubview(separatorView)
        view.addSubview(addNewHighlightButton)
        
        //---TabBarView
        let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        self.tabBarHeight = tabBarHeight + bottomInset
        
        tabBarViewTopConstraint = tabBarView.topAnchor.constraint(equalTo: view.topAnchor,
                                                                  constant: UIScreen.main.bounds.height - buttonTopInset)
        
        NSLayoutConstraint.activate([
            tabBarViewTopConstraint,
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: tabBarHeight + bottomInset)
        ])
        
        //---EmptyView
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: tabBarView.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 120.0)
        ])
        
        //---TabBarItems
        let constToSide: CGFloat = 35.0
        let  itemHeight: CGFloat = 35.0
        let itemWidth: CGFloat = 60.0
        
        NSLayoutConstraint.activate([
            leftTabBarItem.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: +constToSide),
            leftTabBarItem.bottomAnchor.constraint(equalTo: tabBarView.safeAreaLayoutGuide.bottomAnchor),
            leftTabBarItem.widthAnchor.constraint(equalToConstant: itemWidth),
            leftTabBarItem.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
        
        NSLayoutConstraint.activate([
            rightTabBarItem.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -constToSide),
            rightTabBarItem.bottomAnchor.constraint(equalTo: tabBarView.safeAreaLayoutGuide.bottomAnchor),
            rightTabBarItem.widthAnchor.constraint(equalToConstant: itemWidth),
            rightTabBarItem.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
        
        //---SeparatorView
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: tabBarView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        //---AddNewButton
        buttonTopConstraint = addNewHighlightButton.topAnchor.constraint(equalTo: tabBarView.topAnchor,
                                                                         constant: +tabBarHeight + buttonSize)
        
        NSLayoutConstraint.activate([
            addNewHighlightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonTopConstraint,
            addNewHighlightButton.widthAnchor.constraint(equalToConstant: buttonSize),
            addNewHighlightButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
}
