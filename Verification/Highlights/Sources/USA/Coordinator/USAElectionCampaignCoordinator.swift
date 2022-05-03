//
//  AllHighlightsCoordinator.swift
//  Verification
//
//  Created by Мехрафруз on 07.04.2021.
//

import UIKit

protocol USAElectionCampaignCoordinatorProtocol: CoordinatorProtocol {
}

final class USAElectionCampaignCoordinator: USAElectionCampaignCoordinatorProtocol {
    func pushAllHighlights(allHighlightInCategory: CategoryHighlightInfo) {
    }
    
    
    //MARK: - Properties
    var navigationController: UINavigationController
    private let assemblyBuilder = USAElectionCampaignAssemblyBuilder()
    
    //MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        startModule()
    }
    
    //MARK: - Methods
    //---Self setup
    func startModule() {
        customizeTabBar()
        let controller = assemblyBuilder.createAllHighlights(coordinator: self)
        navigationController.setViewControllers([controller], animated: false)
    }
    
    func customizeTabBar() {
        
    }
}
