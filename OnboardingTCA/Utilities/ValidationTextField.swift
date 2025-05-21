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
}

public struct ValidationTextField: ViewModifier {
    var label: LocalizedStringKey?
    var error: String?
    var isNotEmpty: Bool
    
    public func body(content: Content) -> some View {
        HStack(alignment: .bottom) {
            if let label {
                Text(label)
                    .font(.custom("Helvetica Neue", size: 18))
                    .foregroundStyle(Color.indigoBlue.opacity(0.8))
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
                    .overlay(isNotEmpty ? error == nil ? Color.indigoGreen : Color.indigoPink : Color.indigoPurple)
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
