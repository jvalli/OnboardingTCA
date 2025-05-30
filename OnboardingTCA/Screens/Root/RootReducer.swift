//
//  RootReducer.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/29/25.
//

import ComposableArchitecture

public enum AppSettings: String {
    case currentAppView
}

public enum AppView: Int {
    case onboarding, main
}

@Reducer
struct RootReducer {
    @ObservableState
    struct State: Equatable {
        @Shared(.appStorage(AppSettings.currentAppView.rawValue)) var currentAppView: AppView = .onboarding
    }
}
