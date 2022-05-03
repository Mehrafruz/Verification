//
//  GermanyView.swift
//  Verification
//
//  Created by Мехрафруз on 12.06.2021.
//

import UIKit

protocol GermanyElectionCampaignViewDelegate: AnyObject {
}

final class GermanyElectionCampaignView: UIView {
    
    //MARK: - Properties
    private weak var delegate: GermanyElectionCampaignViewDelegate?

    private var topHeaderImageConstraint = NSLayoutConstraint()
    private var topHeaderHideConst: CGFloat = -100.0
    private var topHeaderShowConst: CGFloat = UIDevice().isSmallDevice ? -29.0 : -24.0
    public var firstCellMaxY: CGFloat = 0
    
    //MARK: - Views
    //---NavBar Views
    public let navBarHeaderImageView: MaskedImageView = {
        let imageView = MaskedImageView(image: R.image.allHighlightsNavBarHeader())
        imageView.setShadows(color: UIColor.black.withAlphaComponent(0.3),
                             offSet: CGSize(width: 0, height: 5.0),
                             shadowOpacity: 5.0,
                             shadowRadius: 10.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let settingsNavButton = UIButton.createNavBarButton(size: 30.0, image: R.image.menuNavBarItem())
    private let infoNavButton = UIButton.createNavBarButton(size: 30.0, image: R.image.infoNavBarItem())
    
    //---NavBar Separator
    public let navBarSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "E5E5E5")
        view.alpha = 0.0
        return view
    }()
    
    public var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let firstLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 15)
        label.text = "Соревновательность в правящей партии"
        label.textColor = .black
        return label
    }()
    
    public let firstTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let secondLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 18)
        label.text = "Участие действующего канцлера"
        label.textColor = .black
        return label
    }()
    
    public let secondTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let thirdLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 16)
        label.text = "Третья партия"
        label.textColor = .black
        return label
    }()
    
    public let thirdTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let fourthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 18)
        label.text = "Разница количества депутатов"
        label.textColor = .black
        return label
    }()
    
    public let fouthrTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let fifthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 16)
        label.text = "Превосходство «второй» партии"
        label.textColor = .black
        return label
    }()
    
    public let fifthTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let sixthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 18)
        label.text = "Текущая экономика"
        label.textColor = .black
        return label
    }()
    
    public let sixthTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let seventhLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 18)
        label.text = "Долгосрочная экономика"
        label.textColor = .black
        return label
    }()
    
    public let seventhTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let eighthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 18)
        label.text = "Социальные волнения"
        label.textColor = .black
        return label
    }()
    
    public let eighthTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let ninthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 18)
        label.text = "Скандальность"
        label.textColor = .black
        return label
    }()
    
    public let ninthTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()

    private let tenthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 16)
        label.text = "Ошибки в международной политике"
        label.textColor = .black
        return label
    }()
    
    public let tenthTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let eleventhLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 16)
        label.text = "Успехи в международной политике"
        label.textColor = .black
        return label
    }()
    
    public let eleventhTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let twelfthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 16)
        label.text = "Харизмитичность правящей партии"
        label.textColor = .black
        return label
    }()
    
    public let twelfthTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    
    private let thirteenthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.rubikRegular(size: 18)
        label.text = "Харизмитичность оппонента"
        label.textColor = .black
        return label
    }()
    
    public let thirteenthTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "0",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    //MARK: - Init
    init(subscriber: GermanyElectionCampaignViewDelegate?) {
        self.delegate = subscriber
        [firstTextField, secondTextField, thirdTextField, fouthrTextField, fifthTextField, sixthTextField, seventhTextField, eighthTextField, ninthTextField, tenthTextField, eleventhTextField, twelfthTextField, thirteenthTextField].forEach {
            ($0).delegate = subscriber as? UITextFieldDelegate
        }
        super.init(frame: CGRect())
        registerForKeyboardNotifikation()
        customizeView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    deinit {
        removeForKeyboardNotifikation()
    }
    
    func registerForKeyboardNotifikation(){
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeForKeyboardNotifikation(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: 0)//kbFrameSize.height/4)
    }
    
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint(x: 0, y: -80)
    }
    
    //---Initial setup
    private func customizeView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        backgroundColor = UIColor(red: 246 / 255, green: 247 / 255, blue: 252 / 255, alpha: 1.0)
    }
    
    public func configureNavBar(navigationBar: UINavigationBar?, navigationItem: UINavigationItem) {
        navigationBar?.tintColor = UIColor(hexString: "010202")
        
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        
        //Add ImageView on navBar
        navigationBar?.addSubview(navBarHeaderImageView)
        
        topHeaderImageConstraint = navBarHeaderImageView.topAnchor.constraint(equalTo: navigationBar!.topAnchor, constant: topHeaderHideConst)
        NSLayoutConstraint.activate([
            topHeaderImageConstraint,
            navBarHeaderImageView.centerXAnchor.constraint(equalTo: navigationBar!.centerXAnchor),
            navBarHeaderImageView.widthAnchor.constraint(equalToConstant: 223),
            navBarHeaderImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    //---Animate stuff
    public func hideHeaderImage(navigationBar: UIView?) {
        topHeaderImageConstraint.constant = topHeaderHideConst
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 2.5, options: .curveEaseInOut) {
            navigationBar?.layoutIfNeeded()
        }
    }
    
    public func showHeaderImage(navigationBar: UIView?) {
        topHeaderImageConstraint.constant = topHeaderShowConst
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 2.5, options: .curveEaseInOut) {
            navigationBar?.layoutIfNeeded()
        }
    }
    
    //---Layout
    private func setConstraints() {
        addSubview(navBarSeparator)
        addSubview(scrollView)
        [firstLabel,
         firstTextField,
         secondLabel,
         secondTextField,
         thirdLabel,
         thirdTextField,
         fourthLabel,
         fouthrTextField,
         fifthLabel,
         fifthTextField,
         sixthLabel,
         sixthTextField,
         seventhLabel,
         seventhTextField,
         eighthLabel,
         eighthTextField,
         ninthLabel,
         ninthTextField,
         tenthLabel,
         tenthTextField,
         eleventhLabel,
         eleventhTextField,
         twelfthLabel,
         twelfthTextField,
         thirteenthLabel,
         thirteenthTextField].forEach{
            scrollView.addSubview($0)
        }
        
        let const: CGFloat = 50
        NSLayoutConstraint.activate([
            navBarSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBarSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBarSeparator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navBarSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            firstLabel.heightAnchor.constraint(equalToConstant: 40),
            firstLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            firstLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            firstTextField.topAnchor.constraint(equalTo: firstLabel.topAnchor, constant: 0),
            firstTextField.heightAnchor.constraint(equalToConstant: 40),
            firstTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            firstTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: firstLabel.topAnchor, constant: const),
            secondLabel.heightAnchor.constraint(equalToConstant: 40),
            secondLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            secondLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            secondTextField.topAnchor.constraint(equalTo: secondLabel.topAnchor, constant: 0),
            secondTextField.heightAnchor.constraint(equalToConstant: 40),
            secondTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            secondTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            thirdLabel.topAnchor.constraint(equalTo: secondLabel.topAnchor, constant: const),
            thirdLabel.heightAnchor.constraint(equalToConstant: 40),
            thirdLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            thirdLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            thirdTextField.topAnchor.constraint(equalTo: thirdLabel.topAnchor, constant: 0),
            thirdTextField.heightAnchor.constraint(equalToConstant: 40),
            thirdTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            thirdTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            fourthLabel.topAnchor.constraint(equalTo: thirdLabel.topAnchor, constant: const),
            fourthLabel.heightAnchor.constraint(equalToConstant: 40),
            fourthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            fourthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            fouthrTextField.topAnchor.constraint(equalTo: fourthLabel.topAnchor, constant: 0),
            fouthrTextField.heightAnchor.constraint(equalToConstant: 40),
            fouthrTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            fouthrTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            fifthLabel.topAnchor.constraint(equalTo: fourthLabel.topAnchor, constant: const),
            fifthLabel.heightAnchor.constraint(equalToConstant: 40),
            fifthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            fifthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            fifthTextField.topAnchor.constraint(equalTo: fifthLabel.topAnchor, constant: 0),
            fifthTextField.heightAnchor.constraint(equalToConstant: 40),
            fifthTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            fifthTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            sixthLabel.topAnchor.constraint(equalTo: fifthLabel.topAnchor, constant: const),
            sixthLabel.heightAnchor.constraint(equalToConstant: 40),
            sixthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            sixthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            sixthTextField.topAnchor.constraint(equalTo: sixthLabel.topAnchor, constant: 0),
            sixthTextField.heightAnchor.constraint(equalToConstant: 40),
            sixthTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            sixthTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            seventhLabel.topAnchor.constraint(equalTo: sixthLabel.topAnchor, constant: const),
            seventhLabel.heightAnchor.constraint(equalToConstant: 40),
            seventhLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            seventhLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            seventhTextField.topAnchor.constraint(equalTo: seventhLabel.topAnchor, constant: 0),
            seventhTextField.heightAnchor.constraint(equalToConstant: 40),
            seventhTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            seventhTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            eighthLabel.topAnchor.constraint(equalTo: seventhLabel.topAnchor, constant: const),
            eighthLabel.heightAnchor.constraint(equalToConstant: 40),
            eighthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            eighthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            eighthTextField.topAnchor.constraint(equalTo: eighthLabel.topAnchor, constant: 0),
            eighthTextField.heightAnchor.constraint(equalToConstant: 40),
            eighthTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            eighthTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            ninthLabel.topAnchor.constraint(equalTo: eighthLabel.topAnchor, constant: const),
            ninthLabel.heightAnchor.constraint(equalToConstant: 40),
            ninthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            ninthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            ninthTextField.topAnchor.constraint(equalTo: ninthLabel.topAnchor, constant: 0),
            ninthTextField.heightAnchor.constraint(equalToConstant: 40),
            ninthTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            ninthTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            tenthLabel.topAnchor.constraint(equalTo: ninthLabel.topAnchor, constant: const),
            tenthLabel.heightAnchor.constraint(equalToConstant: 40),
            tenthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            tenthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            tenthTextField.topAnchor.constraint(equalTo: tenthLabel.topAnchor, constant: 0),
            tenthTextField.heightAnchor.constraint(equalToConstant: 40),
            tenthTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            tenthTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            eleventhLabel.topAnchor.constraint(equalTo: tenthLabel.topAnchor, constant: const),
            eleventhLabel.heightAnchor.constraint(equalToConstant: 40),
            eleventhLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            eleventhLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            eleventhTextField.topAnchor.constraint(equalTo: eleventhLabel.topAnchor, constant: 0),
            eleventhTextField.heightAnchor.constraint(equalToConstant: 40),
            eleventhTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            eleventhTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            twelfthLabel.topAnchor.constraint(equalTo: eleventhLabel.topAnchor, constant: const),
            twelfthLabel.heightAnchor.constraint(equalToConstant: 40),
            twelfthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            twelfthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            twelfthTextField.topAnchor.constraint(equalTo: twelfthLabel.topAnchor, constant: 0),
            twelfthTextField.heightAnchor.constraint(equalToConstant: 40),
            twelfthTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            twelfthTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            thirteenthLabel.topAnchor.constraint(equalTo: twelfthLabel.topAnchor, constant: const),
            thirteenthLabel.heightAnchor.constraint(equalToConstant: 40),
            thirteenthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            thirteenthLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            thirteenthTextField.topAnchor.constraint(equalTo: thirteenthLabel.topAnchor, constant: 0),
            thirteenthTextField.heightAnchor.constraint(equalToConstant: 40),
            thirteenthTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            thirteenthTextField.widthAnchor.constraint(equalToConstant: 40),
        ])
        
    }
}
