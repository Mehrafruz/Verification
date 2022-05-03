//
//  Coordinator.swift
//  Verification
//
//  Created by Мехрафруз on 07.04.2021.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get }
    init(navigationController: UINavigationController)
    func startModule()
}

extension CoordinatorProtocol {
    func dismissController(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
    
    func popController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func presentController(controller: UIViewController, animated: Bool) {
        navigationController.present(controller, animated: animated)
    }
    
    func pushController(controller: UIViewController, animated: Bool) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func presentOnPresentedScreen(controller: UIViewController, animated: Bool) {
        navigationController.presentedViewController?.present(controller, animated: true, completion: nil)
    }
    
    func dismissPresentedControllerOnPresent(animated: Bool) {
        navigationController.presentedViewController?.dismiss(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.navigationBar.isHidden = false
        navigationController.popToRootViewController(animated: animated)
    }
    
    func hideTabBar() {
        navigationController.tabBarController?.tabBar.isHidden = true
    }
    
    func showTabBar() {
        navigationController.tabBarController?.tabBar.isHidden = false
    }
    
    func hideTabBarWithAnimation() {
        if let tabBarVC = self.navigationController.tabBarController as? TabBarController {
            tabBarVC.animateHideTabBar()
        }
    }
    
    func showTabBarWithAnimation() {
        if let tabBarVC = self.navigationController.tabBarController as? TabBarController {
            tabBarVC.animateShowTabBar()
        }
    }
    
    func disableSwipePopUp() {
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func enableSwipePopUp() {
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
    }
}

