//
//  TabBarModel.swift
//  Verification
//
//  Created by Мехрафруз on 09.04.2021.
//

import Foundation

final class TabBarModel {
    
    //MARK: - Properties
    public var isFirstStart = true
    
    struct BasicCell {
        let title: String
        let selectedImageName: String
        let defaultImageName: String
    }
    
    public let allCells: [BasicCell] = [BasicCell(title: "USA", selectedImageName: "", defaultImageName: ""),
                                        BasicCell(title: "Germany", selectedImageName: "", defaultImageName: "")]
    
}
