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
    }
    
    var body: some View {
        VStack {
            switch store.viewState {
            case .initial:
                VStack(spacing: Constants.textFieldSpace) {
                    Text(Localizable.pleaseEnterYourInformation.stringKey)
                    HStack(alignment: .bottom) {
                        Text(Localizable.fullName.stringKey)
                        VStack(spacing: .zero) {
                            TextField(.empty, text: $store.fullName)
                                .autocapitalization(.words)
                                .keyboardType(.namePhonePad)
                                .disableAutocorrection(true)
                            Divider()
                        }
                    }
                    HStack(alignment: .bottom) {
                        Text(Localizable.email.stringKey)
                        VStack(spacing: .zero) {
                            TextField(.empty, text: $store.email)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .keyboardType(.emailAddress)
                            Divider()
                        }
                    }
                    HStack(alignment: .bottom) {
                        Text(Localizable.password.stringKey)
                        VStack(spacing: .zero) {
                            SecureField(.empty, text: $store.password)
                            Divider()
                        }
                    }
                    Button(Localizable.send.stringKey) {
                        store.send(.onClickSendButton)
                    }
                    Spacer()
                }
            case .loading:
                ProgressView(Localizable.loading.stringKey)
                    .progressViewStyle(.circular)
                    .tint(.accentColor)
            case .error:
                Text(Localizable.error.stringKey)
                    .foregroundColor(.red)
            case .registered:
                Text(Localizable.userRegistered.stringKey)
                    .foregroundColor(.mint)
            }
            
        }
        .padding(Constants.mainViewPadding)
        .navigationTitle(Text(Localizable.register.stringKey))
    }
}

#Preview {
    NavigationStack {
        RegisterView(store: Store(initialState: RegisterReducer.State()) {
            RegisterReducer()
        })
    }
}
