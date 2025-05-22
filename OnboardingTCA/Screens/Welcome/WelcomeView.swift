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
        static let mainViewPadding: CGFloat = 20
        static let textSpace: CGFloat = 30
        static let messageTextColorOpacity = 0.8
    }
    
    var body: some View {
        ZStack {
            AnimatedGradientView()
            VStack(spacing: Constants.textSpace) {
                Text(Localizable.onboardingTCAApp.stringKey)
                    .font(.sfProDisplay(size: .titleSize))
                    .foregroundStyle(Color.indigoPurple)
                Text(store.state.message)
                    .font(.helveticaNeue(size: .messageSize))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.indigoBlue.opacity(Constants.messageTextColorOpacity))
                Button(Localizable.start.stringKey) {
                    destination = .loginView
                }
                .buttonStyle(.label)
            }
            .padding(Constants.mainViewPadding)
            .onAppear {
                store.send(.viewDidAppear)
            }
            .navigationDestination(item: $destination.loginView) {_ in
                RegisterView(store: .init(initialState: RegisterReducer.State()) {
                    RegisterReducer()
                })
            }
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
