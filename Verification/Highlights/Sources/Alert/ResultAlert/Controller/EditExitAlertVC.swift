//
//  EditExitAlertVC.swift
//  Verification
//
//  Created by Мехрафруз on 20.05.2021.
//

import UIKit

final class EditExitAlertVC: UIViewController {
    
    //MARK: - Properties
    lazy private var mainView = EditExitAlertView(subscriber: self)
    
    //MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = mainView
        followGestureDown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.animateShowView()
    }
    
    //MARK: - Methods
    private func followGestureDown() {
        mainView.swipeDownAction = {
            self.backButtonAction()
        }
    }
    
    public func reloadData (text: String){
        mainView.descriptionLabel.text = text
    }
}

//MARK: - MainView Delegate
extension EditExitAlertVC: EditExitAlertViewDelegate {
    func backButtonAction() {
        mainView.animateHideView { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: false)
        }
    }
    
    func continueButtonAction() {
        mainView.animateHideView { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: false)
        }
    }
}
