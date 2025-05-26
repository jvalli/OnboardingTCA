//
//  ValidationTextField.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/21/25.
//

import SwiftUI

private struct Constants {
    static let iconCheck = "checkmark.circle.fill"
    static let iconX = "x.circle.fill"
    static let labelOpacity = 0.8
}

public struct ValidationTextField: ViewModifier {
    var label: LocalizedStringKey?
    var error: String?
    var isNotEmpty: Bool
    
    @State private var shakeOffset = 0.0
    @FocusState private var isFocused: Bool
    
    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                if let label {
                    Text(label)
                        .font(.helveticaNeue(size: .labelTextFieldSize))
                        .foregroundStyle(Color.indigoBlue.opacity(Constants.labelOpacity))
                        .bold()
                }
                VStack(spacing: .zero) {
                    HStack {
                        content
                            .foregroundStyle(Color.indigoBlue)
                            .accentColor(Color.indigoBlue)
                            .focused($isFocused)
                        if isNotEmpty {
                            Image(systemName: error == nil ? Constants.iconCheck : Constants.iconX)
                                .foregroundColor(error == nil ? .indigoGreen : .indigoPink)
                        }
                    }
                    Divider()
                        .overlay(isNotEmpty ? error == nil ? Color.indigoGreen : Color.indigoPink : Color.indigoBlue)
                }
                .modifier(ShakeEffect(shakeOffset: shakeOffset))
                .onChange(of: isFocused) { oldValue, newValue in
                    if !newValue, newValue != oldValue, isNotEmpty, error != nil {
                        withAnimation(.linear(duration: 0.1).repeatCount(5, autoreverses: true)) {
                            shakeOffset = 10.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            shakeOffset = 0.0
                        }
                    }
                }
            }
            if isNotEmpty, let error, error.isNotEmpty {
                Text(error)
                    .font(.helveticaNeue(size: .errorTextFieldSize))
                    .foregroundStyle(Color.indigoPink)
            }
        }
    }
}

struct ShakeEffect: GeometryEffect {
    var shakeOffset: CGFloat
    
    var animatableData: CGFloat {
        get { shakeOffset }
        set { shakeOffset = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: shakeOffset, y: 0))
    }
}

public extension TextField {
    @MainActor func validationTextField(label: LocalizedStringKey?, error: String?, isNotEmpty: Bool) -> some View {
        modifier(ValidationTextField(label: label, error: error, isNotEmpty: isNotEmpty))
    }
}

public extension SecureField {
    @MainActor func validationTextField(label: LocalizedStringKey?, error: String?, isNotEmpty: Bool) -> some View {
        modifier(ValidationTextField(label: label, error: error, isNotEmpty: isNotEmpty))
    }
}
