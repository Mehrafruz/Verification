//
//  EditExitAlertView.swift
//  Verification
//
//  Created by Мехрафруз on 20.05.2021.
//

import UIKit

protocol EditExitAlertViewDelegate: class {
    func backButtonAction()
    func continueButtonAction()
}

final class EditExitAlertView: RootAlertView {
    //MARK: - Properties
    private weak var delegate: EditExitAlertViewDelegate?

    //MARK: - Views
    //---EmojiImageView
    private let emojiImageView: MaskedImageView =  {
        let imageView = MaskedImageView(image: R.image.upsetEmoji())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setShadows(color: UIColor.gray, offSet: CGSize(width: 10, height: 10), shadowOpacity: 10, shadowRadius: 20)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //---TitleLabel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = ColorsPalette.AlertScreen.textColor.getColor()
        label.numberOfLines = 3
        let attributedString = NSMutableAttributedString(
            string: "Вероятность победы\nтекущей администрации",
            attributes: [
                NSAttributedString.Key.font: R.font.rubikBold(size: 20) ?? UIFont.systemFont(ofSize: 20)]
        )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        return label
    }()
    
    //---DescriptionLabel
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = ColorsPalette.AlertScreen.textColor.getColor()
        label.numberOfLines = 3
        label.font = R.font.rubikRegular(size: 16)

//        let attributedString = NSMutableAttributedString(
//            string: "0.05320096",
//            attributes: [
//                NSAttributedString.Key.font: R.font.rubikRegular(size: 16) ?? UIFont.systemFont(ofSize: 16)]
//        )
        
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.2
//        paragraphStyle.alignment = .center
//        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
//        label.attributedText = attributedString
        return label
    }()
    
    //---CancelButton
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ок", for: .normal)
        button.titleLabel?.font = R.font.rubikRegular(size: 20)
        button.setTitleColor(UIColor.green, for: .normal)
        return button
    }()

    

    //---HorizontalView
    private let horizontalLineView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorsPalette.AlertScreen.buttonBorderColor.getColor().withAlphaComponent(0.3)
        return view
    }()
    
    //--ButtonsStackView
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - Init
    init(subscriber: EditExitAlertViewDelegate) {
        super.init(widthMultiply: 0.77, heightMultiply: 1.0)
        self.delegate = subscriber
        setupButtons()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.hideOffSet = emojiImageView.frame.height / 2
    }
    
    //MARK: - Methods
    //--Buttons
    private func setupButtons() {
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    //--ButtonAction
    @objc private func buttonAction(sender: UIButton) {
        switch sender {
        case backButton:
            delegate?.backButtonAction()
        default:
            return
        }
    }
    
    //---Layout
    private func setConstraints(){
        [
            buttonsStackView,
            emojiImageView,
            titleLabel,
            descriptionLabel,
            
            horizontalLineView
        ].forEach{
            addSubview($0)
        }
        
        buttonsStackView.addArrangedSubview(backButton)
     
        emojiImageView.isHidden = true
        
        //---Emoji Label
        NSLayoutConstraint.activate([
            emojiImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -53),
            emojiImageView.widthAnchor.constraint(equalToConstant: 104),
            emojiImageView.heightAnchor.constraint(equalToConstant: 104*0.92)
        ])

        //---Title Label
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: emojiImageView.bottomAnchor, constant: 40)
        ])
        
        //---Description Label
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
        
        //---ButtonsStackView
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 48)
        ])

        //---HorizontalLineView
        NSLayoutConstraint.activate([
            horizontalLineView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            horizontalLineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            horizontalLineView.topAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            horizontalLineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
   
        
    }
}
