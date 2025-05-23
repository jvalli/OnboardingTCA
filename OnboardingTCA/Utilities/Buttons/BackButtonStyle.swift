//
//  BackButton.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/23/25.
//

import SwiftUI

private struct Constants {
    static let iconArrowLeft = "arrow.left"
    static let grayOpacity = 0.5
    static let width = 35.0
    static let height = 8.0
    static let padding = 10.0
    static let offset = 0.0
    static let offsetPressed = 1.0
    static let scale = 1.0
    static let scalePressed = 0.98
}

public struct BackButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Image(systemName: Constants.iconArrowLeft)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(Color.gray.opacity(Constants.grayOpacity))
            .frame(width: Constants.width, height: Constants.height)
            .clipped()
            .padding([.vertical, .trailing], Constants.padding)
            .offset(y: configuration.isPressed ? Constants.offsetPressed : Constants.offset)
            .scaleEffect(configuration.isPressed ? Constants.scalePressed : Constants.scale)
    }
}

extension ButtonStyle where Self == BackButtonStyle {
    static var backButton: BackButtonStyle { BackButtonStyle() }
}
