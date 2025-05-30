//
//  RootView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/29/25.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    var store: StoreOf<RootReducer>
    
    struct Constants {
        static let iconHouse = "house"
        static let iconGear = "gear"
    }

    var body: some View {
        Group {
            switch store.currentAppView {
            case .onboarding:
                NavigationStack {
                    WelcomeView(store: Store(initialState: WelcomeReducer.State()) {
                        WelcomeReducer()
                    })
                }
            case .main:
                TabView {
                    HomeView(store: Store(initialState: HomeReducer.State()) {
                        HomeReducer()
                    })
                    .tabItem {
                        Label(
                            Localizable.home.stringKey,
                            systemImage: Constants.iconHouse
                        )
                    }
                    SettingsView(store: Store(initialState: SettingsReducer.State()) {
                        SettingsReducer()
                    })
                    .tabItem {
                        Label(
                            Localizable.settings.stringKey,
                            systemImage: Constants.iconGear
                        )
                    }
                }
            }
        }
        .animation(.easeInOut, value: store.currentAppView)
    }
}

#Preview {
    RootView(store: Store(initialState: RootReducer.State()) {
        RootReducer()
    })
}
