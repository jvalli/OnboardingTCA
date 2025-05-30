//
//  HomeReducer.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/27/25.
//

import ComposableArchitecture

@Reducer
struct HomeReducer {
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action {
        case viewDidAppear
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewDidAppear:
                return .none
            }
        }
    }
}
