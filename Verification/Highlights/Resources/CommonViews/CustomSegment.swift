//
//  HBSegmentedControl.swift
//  HBSegmentedControl
//
//  Created by Hilal Baig on 8/13/17.
//  Copyright © 2017 Hilal Baig. All rights reserved.
//


import UIKit

@IBDesignable public class HBSegmentedControl: UIControl {
    
    fileprivate var labels = [UIImageView]()
    private var thumbView = UIView()
    
    public var items: [UIImage?] = [] {
        didSet {
            if items.count > 0 { setupLabels() }
        }
    }
    
    public var selectedIndex: Int = 0 {
        didSet { displayNewSelectedIndex() }
    }
    
    @IBInspectable public var selectedLabelColor: UIColor = UIColor.black {
        didSet { setSelectedColors() }
    }
    
    @IBInspectable public var unselectedLabelColor: UIColor = UIColor.white {
        didSet { setSelectedColors() }
    }
    
    @IBInspectable public var thumbColor: UIColor = UIColor.white {
        didSet { setSelectedColors() }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    
    @IBInspectable public var font: UIFont? = UIFont.systemFont(ofSize: 12) {
        didSet { setFont() }
    }
    
    public var padding: CGFloat = 3 {
        didSet { setupLabels() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = frame.height / 3
        layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
        layer.borderWidth = 2
        
        backgroundColor = UIColor.clear
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    private func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        guard !items.isEmpty else { return }
        for index in 1...items.count {
            let view = UIImageView()
            view.image = items[index - 1]
            view.backgroundColor = .clear
            
            //view.layer.borderWidth = 3
            //            label.textAlignment = .center
            //            label.font = font
            //            label.font = index == 1 ? UIFont.systemFont(ofSize: 15, weight: .bold) : UIFont.systemFont(ofSize: 15, weight: .medium)
            view.layer.borderColor = index == 1 ? selectedLabelColor.cgColor : unselectedLabelColor.cgColor
            view.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(view)
            labels.append(view)
        }
        
        addIndividualItemConstraints(labels, mainView: self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if labels.count > 0 {
            let label = labels[selectedIndex]
            label.layer.borderColor = selectedLabelColor.cgColor
            thumbView.frame = label.frame
            thumbView.backgroundColor = .none
            thumbView.layer.cornerRadius = 8
            thumbView.layer.borderWidth = 2
            thumbView.layer.borderColor = UIColor(hexString: "FD3A84").cgColor
            thumbView.layer.shadowColor = UIColor.black.cgColor
            thumbView.layer.shadowRadius = 8
            thumbView.layer.shadowOpacity = 0.12
            thumbView.layer.shadowOffset = CGSize(width: 0, height: 4)
            thumbView.layer.zPosition = 2
            displayNewSelectedIndex()
        }
    }
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        var calculatedIndex : Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    private func displayNewSelectedIndex() {
        for (_, item) in labels.enumerated() {
            item.layer.borderColor = unselectedLabelColor.cgColor
            //   item.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        }
        
        let label = labels[selectedIndex]
        label.layer.borderColor = selectedLabelColor.cgColor
        // label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, animations: {
            self.thumbView.frame = CGRect(x: label.frame.minX-3, y: label.frame.minY-3, width: label.frame.width+6, height: label.frame.height+6)
        }, completion: nil)
    }
    
    private func addIndividualItemConstraints(_ items: [UIView], mainView: UIView) {
        for (index, button) in items.enumerated() {
            button.topAnchor.constraint(equalTo: mainView.topAnchor, constant: padding).isActive = true
            button.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -padding).isActive = true
            
            ///set leading constraint
            if index == 0 {
                /// set first item leading anchor to mainView
                button.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: padding).isActive = true
            } else {
                let prevButton: UIView = items[index - 1]
                let firstItem: UIView = items[0]
                
                /// set remaining items to previous view and set width the same as first view
                button.leadingAnchor.constraint(equalTo: prevButton.trailingAnchor, constant: padding).isActive = true
                button.widthAnchor.constraint(equalTo: firstItem.widthAnchor).isActive = true
            }
            
            ///set trailing constraint
            if index == items.count - 1 {
                /// set last item trailing anchor to mainView
                button.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -padding).isActive = true
            } else {
                /// set remaining item trailing anchor to next view
                let nextButton: UIView = items[index + 1]
                button.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -padding).isActive = true
            }
        }
    }
    
    private func setSelectedColors() {
        for item in labels {
            item.layer.borderColor = unselectedLabelColor.cgColor
        }
        
        if labels.count > 0 {
            labels[0].layer.borderColor = selectedLabelColor.cgColor
        }
        
        thumbView.backgroundColor = thumbColor
    }
    
    private func setFont() {
        //        for item in labels {
        //            //item.font = font
        //        }
    }
}
