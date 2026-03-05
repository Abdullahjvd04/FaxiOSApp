//
//  FontExtension.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//

import SwiftUI

enum AppFont: String {
    case regular = "Baloo2-Regular"
    case bold    = "Baloo2-Bold"
    case medium = "Baloo2-Medium"
    case semiBold = "Baloo2-SemiBold"
    
    func size(_ size: CGFloat) -> Font {
        return .custom(self.rawValue, size: size)
    }
}



