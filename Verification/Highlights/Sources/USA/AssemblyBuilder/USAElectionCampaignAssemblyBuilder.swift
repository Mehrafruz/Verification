//
//  AllHighlightsAssemblyBuilder.swift
//  Verification
//
//  Created by Мехрафруз on 07.04.2021.
//

import UIKit

final class USAElectionCampaignAssemblyBuilder {
    
    //MARK: - AllHighlightsVC
    public func createAllHighlights(
        coordinator: USAElectionCampaignCoordinatorProtocol
    ) -> UIViewController {
        
        let model = USAElectionCampaignModel()
        let controller = USAElectionCampaignVC(coordinator: coordinator, model: model)
        controller.modalPresentationStyle = .fullScreen
        
        return controller
    }
}
