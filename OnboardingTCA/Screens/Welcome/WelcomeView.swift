//
//  WelcomeView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture
import SwiftUI

struct WelcomeView: View {
    @Bindable var store: StoreOf<WelcomeReducer>
    
    struct Constants {
        static let mainViewPadding = 20.0
        static let textSpace = 30.0
        static let messageTextColorOpacity = 0.8
        static let typingTextAnimationSpeed = 0.05
        static let typingTextHeight = 60.0
    }
    
    var body: some View {
        ZStack {
            AnimatedGradientView()
            VStack(spacing: Constants.textSpace) {
                Text(Localizable.onboardingTCAApp.stringKey)
                    .font(.sfProDisplay(size: .titleSize))
                    .foregroundStyle(Color.indigoPurple)
                TypingText(text: store.message, speed: Constants.typingTextAnimationSpeed)
                .frame(height: Constants.typingTextHeight)
                Button(Localizable.start.stringKey) {
                    store.send(.onClickStartButton)
                }
                .buttonStyle(.label)
            }
            .padding(Constants.mainViewPadding)
        }
        .onAppear {
            store.send(.viewDidAppear)
        }
        .navigationDestination(item: $store.scope(
            state: \.destination?.showRegisterView,
            action: \.destination.showRegisterView
        )) { store in
            RegisterView(store: store)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    NavigationStack {
        WelcomeView(store: .init(initialState: WelcomeReducer.State()) {
            WelcomeReducer()
        })
    }
}
