//
//  AppCoordinator.swift
//  Verification
//
//  Created by Мехрафруз on 07.04.2021.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func startApplication() -> UIViewController
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    //MARK: - Methods
    func startApplication() -> UIViewController {
            return TabBarController()
        }
    
    
}

