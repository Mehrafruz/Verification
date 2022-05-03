//
//  AllHighlightsModel.swift
//  Verification
//
//  Created by Мехрафруз on 07.04.2021.
//

import UIKit

protocol USAElectionCampaignModelProtocol {
    var isFirstStart: Bool { get set }
}

final class USAElectionCampaignModel: USAElectionCampaignModelProtocol {

    public var isFirstStart = true
}
