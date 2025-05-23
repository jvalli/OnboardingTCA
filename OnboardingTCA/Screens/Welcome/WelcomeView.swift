//
//  WelcomeView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture
import SwiftUI

struct WelcomeView: View {
    let store: StoreOf<WelcomeReducer>
    
    @State var destination: Destination?
    
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
                TypingText(text: store.state.message, speed: Constants.typingTextAnimationSpeed)
                .frame(height: Constants.typingTextHeight)
                Button(Localizable.start.stringKey) {
                    destination = .loginView
                }
                .buttonStyle(.label)
            }
            .padding(Constants.mainViewPadding)
        }
        .onAppear {
            store.send(.viewDidAppear)
        }
        .navigationDestination(item: $destination.loginView) {_ in
            RegisterView(store: .init(initialState: RegisterReducer.State()) {
                RegisterReducer()
            })
        }
        .ignoresSafeArea(.all)
    }
}

@CasePathable
enum Destination {
    case loginView
}

#Preview {
    NavigationStack {
        WelcomeView(store: .init(initialState: WelcomeReducer.State()) {
            WelcomeReducer()
        })
    }
}
