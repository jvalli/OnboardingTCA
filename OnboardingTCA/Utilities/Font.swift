//
//  Font.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/22/25.
//

import SwiftUI

extension Font {
    static func helveticaNeue(size: CGFloat) -> Font {
        .custom("Helvetica Neue", size: size)
    }
    
    static func sfProDisplay(size: CGFloat) -> Font {
        .custom("SF Pro Display", size: size)
    }
}

extension CGFloat {
    static let titleSize: CGFloat = 32
    static let navTitleSize: CGFloat = 24
    static let headlineSize: CGFloat = 18
    static let labelTextFieldSize: CGFloat = 18
    static let messageSize: CGFloat = 16
    static let errorTextFieldSize: CGFloat = 12
}
