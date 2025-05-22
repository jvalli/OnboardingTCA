//
//  LabelButton.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/22/25.
//

import SwiftUI

private struct Constants {
    static let cornerRadius: CGFloat = 8.0
    static let bacgroundOpacity: CGFloat = 0.8
    static let buttonHeight: CGFloat = 50.0
    static let shadowOpacity: CGFloat = 0.4
    static let shadowOpacityPressed: CGFloat = 0.2
    static let shadowRadius: CGFloat = 3.0
    static let shadowRadiusPressed: CGFloat = 1.0
    static let offset: CGFloat = 0.0
    static let offsetPressed: CGFloat = 1.0
    static let scale: CGFloat = 1.0
    static let scalePressed: CGFloat = 0.98
    static let animationSpringResponse: CGFloat = 0.3
    static let animationSpringDampingFraction: CGFloat = 0.5
}

public struct LabelButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.indigoBlue.opacity(Constants.bacgroundOpacity),
                            Color.indigoPurple.opacity(Constants.bacgroundOpacity)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(
                    color: .black.opacity(configuration.isPressed ? Constants.shadowOpacityPressed : Constants.shadowOpacity),
                    radius: configuration.isPressed ? Constants.shadowRadiusPressed : Constants.shadowRadius,
                    x: .zero,
                    y: configuration.isPressed ? Constants.shadowRadiusPressed : Constants.shadowRadius
                )
            configuration.label
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
                .bold()
        }
        .frame(height: Constants.buttonHeight)
        .offset(y: configuration.isPressed ? Constants.offsetPressed : Constants.offset)
        .scaleEffect(configuration.isPressed ? Constants.scalePressed : Constants.scale)
        .animation(
            .spring(
                response: Constants.animationSpringResponse,
                dampingFraction: Constants.animationSpringDampingFraction
            ),
            value: configuration.isPressed
        )
    }
}

extension ButtonStyle where Self == LabelButtonStyle {
    static var label: LabelButtonStyle { LabelButtonStyle() }
}
