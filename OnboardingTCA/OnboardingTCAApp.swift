//
//  OnboardingTCAApp.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct OnboardingTCAApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView(store: Store(initialState: WelcomeReducer.State()) {
                    WelcomeReducer()
                })
            }
        }
    }
}
