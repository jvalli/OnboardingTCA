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
        static let textTitle = "Onboarding TCA App"
        static let buttonStart = "Start"
    }
    
    var body: some View {
        VStack(spacing: Constants.textSpace) {
            Text(Constants.textTitle)
                .bold()
                .font(.largeTitle)
            Text(store.state.message)
                .multilineTextAlignment(.center)
            Button(Constants.buttonStart) {
                destination = .loginView
            }
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
