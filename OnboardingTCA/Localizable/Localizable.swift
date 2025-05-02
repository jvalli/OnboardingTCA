//
//  Localizable.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/2/25.
//

import SwiftUI

enum Localizable: String {
    /// Welcome Screen
    case onboardingTCAApp = "onboarding_tca_app"
    case start
    /// Registration Screen
    case pleaseEnterYourInformation = "please_enter_your_information"
    case fullName = "full_name"
    case email
    case password
    case send
    case loading
    case error
    case userRegistered = "user_registered"
    case register
}

extension Localizable {
    var resource: LocalizedStringResource {
        LocalizedStringResource(stringLiteral: self.rawValue)
    }
    
    var stringKey: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}
