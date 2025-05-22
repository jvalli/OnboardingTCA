//
//  ValidationTextField.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/21/25.
//

import SwiftUI

private struct Constants {
    static let iconCheck: String = "checkmark.circle.fill"
    static let iconX: String = "x.circle.fill"
    static let labelOpacity: CGFloat = 0.8
}

public struct ValidationTextField: ViewModifier {
    var label: LocalizedStringKey?
    var error: String?
    var isNotEmpty: Bool
    
    public func body(content: Content) -> some View {
        VStack {
            HStack(alignment: .bottom) {
                if let label {
                    Text(label)
                        .font(.helveticaNeue(size: .labelTextFieldSize))
                        .foregroundStyle(Color.indigoBlue.opacity(Constants.labelOpacity))
                }
                VStack(spacing: .zero) {
                    HStack {
                        content
                        if isNotEmpty {
                            Image(systemName: error == nil ? Constants.iconCheck : Constants.iconX)
                                .foregroundColor(error == nil ? .indigoGreen : .indigoPink)
                        }
                    }
                    Divider()
                        .overlay(isNotEmpty ? error == nil ? Color.indigoGreen : Color.indigoPink : Color.indigoBlue)
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
