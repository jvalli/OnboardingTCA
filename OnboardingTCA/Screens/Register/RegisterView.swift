//
//  RegisterView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture
import SwiftUI

struct RegisterView: View {
    @Bindable var store: StoreOf<RegisterReducer>
    
    struct Constants {
        static let mainViewPadding: CGFloat = 20
        static let textFieldSpace: CGFloat = 10
        static let textEnterInformation = "Please enter your information"
        static let textFieldFullName = "Full Name:"
        static let textFieldEmail = "Email:"
        static let textFieldPassword = "Password:"
        static let buttonSend = "Send"
        static let textLoading = "Loading"
        static let textError = "Error!!!"
        static let textUserRegistered = "User registered!!!"
        static let textRegister = "Register"
    }
    
    var body: some View {
        VStack {
            switch store.viewState {
            case .initial:
                VStack(spacing: Constants.textFieldSpace) {
                    Text(Constants.textEnterInformation)
                    HStack(alignment: .bottom) {
                        Text(Constants.textFieldFullName)
                        VStack {
                            TextField("", text: $store.fullName)
                                .autocapitalization(.words)
                                .keyboardType(.namePhonePad)
                                .disableAutocorrection(true)
                            Divider()
                        }
                    }
                    HStack(alignment: .bottom) {
                        Text(Constants.textFieldEmail)
                        VStack {
                            TextField("", text: $store.email)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .keyboardType(.emailAddress)
                            Divider()
                        }
                    }
                    HStack(alignment: .bottom) {
                        Text(Constants.textFieldPassword)
                        VStack {
                            SecureField("", text: $store.password)
                            Divider()
                        }
                    }
                    Button(Constants.buttonSend) {
                        store.send(.onClickSendButton)
                    }
                    Spacer()
                }
            case .loading:
                ProgressView(Constants.textLoading)
                    .progressViewStyle(.circular)
                    .tint(.accentColor)
            case .error:
                Text(Constants.textError)
                    .foregroundColor(.red)
            case .registered:
                Text(Constants.textUserRegistered)
                    .foregroundColor(.mint)
            }
            
        }
        .padding(Constants.mainViewPadding)
        .navigationTitle(Text(Constants.textRegister))
    }
}

#Preview {
    NavigationStack {
        RegisterView(store: Store(initialState: RegisterReducer.State()) {
            RegisterReducer()
        })
    }
}
