//
//  RegisterReducer.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture

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
        
        public init(fullName: String = "", email: String = "", password: String = "") {
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
    }
    
    private enum CancelID {
        case signUpRequest
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.fullName):
                // TODO: validate `fullName` format
                return .none
            case .binding(\.email):
                // TODO: validate `email` format
                return .none
            case .binding(\.password):
                // TODO: validate `password` format
                return .none
            case .binding:
                return .none
            case .onClickSendButton:
                let fullName = state.fullName
                let email = state.email
                let password = state.password
                guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty else {
                    state.viewState = .error
                    return .none
                }
                state.viewState = .loading
                return .run { send in
                    let result = try await apiClient.signUp(fullName: fullName, email: email, password: password)
                    await send(.onApiClientResponse(result))
                }
                .cancellable(id: CancelID.signUpRequest)
            case let .onApiClientResponse(result):
                switch result {
                case let .success(user):
                    print(user)
                    state.viewState = .registered
                case let .failure(error):
                    print(error)
                    state.viewState = .error
                }
                return .none
            }
        }
    }
}
