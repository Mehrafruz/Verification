//
//  ColorsPalette.swift
//  Highlights
//
//  Created by Дмитрий Марченков on 16.04.2021.
//

import UIKit

protocol ColorsInfo { }

extension ColorsInfo where Self: RawRepresentable {
    func getColor() -> UIColor {
        return UIColor(hexString: (self.rawValue as? String) ?? "")
    }
}

enum ColorsPalette {
    
    //MARK: - General Colors
    enum GeneralColors: String, ColorsInfo {
        case backgroundColor = "FFFFFF"
        case tabBarColor = "F6F7FC"
        case selectedTextColor = "FD3E85"
    }
    
    //MARK: - AllHighlights Screen
    enum AllHighlightsColors: String, ColorsInfo {
        //---View
        case backgroundColor = "E5E5E5"
        //---Header
        case countTitle = "010202"
        case headerTitle = "#010202"
        case headerAllButton = "FD3E85"
    }
    
    enum PreviewHighlight: String, ColorsInfo {
        case buttonColorLeftGrad = "FD3A84"
        case buttonColorRightGrad = "FFA68D"
        case buttonShadow = "000014"
        case textColor = "#262626"
    }
    
    enum AlertScreen: String, ColorsInfo {
        case textColor = "#0E0048"
        case bottomTextColor = "FD3E85"
        case buttonBorderColor = "0E0048"
    }
    
    
    
}

