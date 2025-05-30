//
//  WelcomeReducer.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WelcomeReducer {
    @ObservableState
    struct State: Equatable {
        var message: String
        @Presents var destination: Destination.State?
        
        public init(message: String = Constants.welcomeMessage) {
            self.message = message
        }
    }
    
    enum Action {
        case viewDidAppear
        case onClickStartButton
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case showRegisterView(RegisterReducer)
    }
    
    struct Constants {
        static let welcomeMessage = "This is a demo application to demostrate the integration of The Composable Architecture (TCA) on a SwiftUI project."
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewDidAppear:
                return .none
            case .onClickStartButton:
                state.destination = .showRegisterView(RegisterReducer.State())
                return .none
            case .destination:
                return .none
            }
        }.ifLet(\.$destination, action: \.destination)
    }
}
