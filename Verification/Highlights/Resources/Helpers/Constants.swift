//
//  Constants.swift
//  Highlights
//
//  Created by Мехрафруз on 10.05.2021.
//

import UIKit


var isSmallDevice: Bool {
    switch UIDevice().screenType {
    case .iPhone8, .iPhone8Plus, .iPhoneSE:
        return true
    default:
        return false
    }
}
