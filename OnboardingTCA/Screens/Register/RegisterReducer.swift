//
//  RegisterReducer.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct RegisterReducer {
    @Dependency(\.apiClient) var apiClient
    
    public enum ViewState: Equatable {
        case initial
        case loading
        case error
        case registered
    }
    
    @ObservableState
    struct State: Equatable {
        var viewState: ViewState
        var fullName: String
        var email: String
        var password: String
        var errorFullName: String? = .empty
        var errorEmail: String? = .empty
        var errorPassword: String? = .empty
        @Shared(.appStorage(AppSettings.currentAppView.rawValue)) var currentAppView: AppView = .onboarding
        
        public init(fullName: String = .empty, email: String = .empty, password: String = .empty) {
            self.fullName = fullName
            self.email = email
            self.password = password
            self.viewState = .initial
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onClickSendButton
        case onApiClientResponse(Result<User, ApiError>)
        case onClickTryAgainButton
        case onClickContinueButton
    }
    
    private enum CancelID {
        case signUpRequest
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.fullName):
                let validName = state.fullName.isNotEmpty && state.fullName.isValidName
                state.errorFullName = !validName ? "Please enter a valid name." : nil
                return .none
            case .binding(\.email):
                let validEmail = state.email.isNotEmpty && state.email.isValidEmail
                state.errorEmail = !validEmail ? "Please enter a valid email." : nil
                return .none
            case .binding(\.password):
                let validPassword = state.password.isNotEmpty && state.password.isValidPassword
                state.errorPassword = !validPassword ? "Please enter a valid password." : nil
                return .none
            case .binding:
                return .none
            case .onClickSendButton:
                guard state.errorFullName == nil, state.errorEmail == nil, state.errorPassword == nil else {
                    state.viewState = .error
                    return .none
                }
                let fullName = state.fullName
                let email = state.email
                let password = state.password
                state.viewState = .loading
                return .run { send in
                    let result = try await apiClient.signUp(fullName: fullName, email: email, password: password)
                    await send(.onApiClientResponse(result))
                }
                .cancellable(id: CancelID.signUpRequest)
            case let .onApiClientResponse(result):
                switch result {
                case .success(_):
                    state.viewState = .registered
                case let .failure(error):
                    state.errorFullName = error.localizedDescription
                    state.viewState = .error
                }
                return .none
            case .onClickTryAgainButton:
                state.viewState = .initial
                return .none
            case .onClickContinueButton:
                state.$currentAppView.withLock { $0 = .main }
                return .none
            }
        }
    }
}
