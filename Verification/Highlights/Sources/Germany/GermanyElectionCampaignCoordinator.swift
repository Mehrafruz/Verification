//
//  GermanyScreenCoordinator.swift
//  Verification
//
//  Created by Мехрафруз on 12.06.2021.
//


import UIKit

protocol GermanyElectionCampaignCoordinatorProtocol: CoordinatorProtocol {
    
}

final class GermanyElectionCampaignCoordinator: GermanyElectionCampaignCoordinatorProtocol {
    
    //MARK: - Properties
    var navigationController: UINavigationController
    //MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        startModule()
    }
    
    //MARK: - Methods
    func startModule() {
        let controller = GermanyElectionCampaignVC()
        controller.modalPresentationStyle = .fullScreen
        self.navigationController.setViewControllers([controller], animated: false)
    }
}
