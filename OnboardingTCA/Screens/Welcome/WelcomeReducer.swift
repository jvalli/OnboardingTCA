//
//  WelcomeReducer.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture

@Reducer
struct WelcomeReducer {
    @ObservableState
    struct State: Equatable {
        var message: String
        
        public init(message: String = Constants.welcomeMessage) {
            self.message = message
        }
    }
    
    enum Action {
        case viewDidAppear
    }
    
    struct Constants {
        static let welcomeMessage = "This is a demo application to demostrate the integration of The Composable Architecture (TCA) on a SwiftUI project."
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewDidAppear:
                //state.message = Constants.welcomeMessage
                return .none
            }
        }
    }
}
