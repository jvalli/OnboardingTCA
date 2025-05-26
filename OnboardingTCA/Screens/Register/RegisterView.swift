//
//  RegisterView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture
import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var store: StoreOf<RegisterReducer>
    
    struct Constants {
        static let mainViewPadding = 20.0
        static let textFieldSpace = 25.0
        static let headlineTextColorOpacity = 0.8
        static let headlineTextPadding = 20.0
        static let buttonPaddingTop = 20.0
        static let toolbarBackgroundOpacity = 0.2
        static let errorTitleSpace = 30.0
        static let errorLabelSpace = 10.0
        static let iconRepeat = "repeat.circle"
    }
    
    init(store: StoreOf<RegisterReducer>) {
        self.store = store
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        VStack {
            switch store.viewState {
            case .initial:
                VStack(spacing: Constants.textFieldSpace) {
                    Text(Localizable.pleaseEnterYourInformation.stringKey)
                        .font(.helveticaNeue(size: .headlineSize))
                        .foregroundStyle(Color.indigoBlue.opacity(Constants.headlineTextColorOpacity))
                        .padding(.bottom, Constants.headlineTextPadding)
                    TextField(.empty, text: $store.fullName)
                        .validationTextField(
                            label: Localizable.fullName.stringKey,
                            error: store.fullName.isValidName ? nil : store.errorFullName,
                            isNotEmpty: store.fullName.isNotEmpty
                        )
                        .autocapitalization(.words)
                        .keyboardType(.namePhonePad)
                        .disableAutocorrection(true)
                    TextField(.empty, text: $store.email)
                        .validationTextField(
                            label: Localizable.email.stringKey,
                            error: store.email.isValidEmail ? nil : store.errorEmail,
                            isNotEmpty: store.email.isNotEmpty
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    SecureField(.empty, text: $store.password)
                        .validationTextField(
                            label: Localizable.password.stringKey,
                            error: store.password.isValidPassword ? nil : store.errorPassword,
                            isNotEmpty: store.password.isNotEmpty
                        )
                    Button(Localizable.send.stringKey) {
                        store.send(.onClickSendButton)
                    }
                    .buttonStyle(.label)
                    .padding(.top, Constants.buttonPaddingTop)
                    Spacer()
                }
            case .loading:
                VStack {
                    Spacer()
                    ProgressView(Localizable.loading.stringKey)
                        .progressViewStyle(.circular)
                        .tint(Color.indigoPurple)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            case .error:
                VStack(spacing: Constants.errorLabelSpace) {
                    Text(Localizable.error.stringKey)
                        .foregroundColor(Color.indigoPink)
                        .font(.sfProDisplay(size: .titleSize))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, Constants.errorTitleSpace)
                    if let errorFullName = store.errorFullName {
                        Text(errorFullName)
                            .foregroundColor(Color.indigoPink)
                    }
                    if let errorEmail = store.errorEmail {
                        Text(errorEmail)
                            .foregroundColor(Color.indigoPink)
                    }
                    if let errorPassword = store.errorPassword {
                        Text(errorPassword)
                            .foregroundColor(Color.indigoPink)
                    }
                    Button {
                        store.send(.onClickTryAgainButton)
                    } label: {
                        Image(systemName: Constants.iconRepeat)
                            .symbolEffect(.pulse)
                            .symbolEffect(.scale.up)
                            .foregroundStyle(Color.indigoPink)
                            .font(.system(size: .titleSize))
                    }
                    Spacer()
                }
            case .registered:
                VStack {
                    Spacer()
                    Text(Localizable.userRegistered.stringKey)
                        .foregroundColor(Color.indigoPurple)
                        .font(.sfProDisplay(size: .titleSize))
                        .frame(maxWidth: .infinity)
                    Button(Localizable.continueButton.stringKey) {
                        store.send(.onClickContinueButton)
                    }
                    .buttonStyle(.label)
                    .padding(.top, Constants.buttonPaddingTop)
                    Spacer()
                }
            }
            
        }
        .padding(Constants.mainViewPadding)
        .background {
            AnimatedGradientView()
        }
        .edgesIgnoringSafeArea(.bottom)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(.empty) {
                    dismiss()
                }
                .buttonStyle(.backButton)
            }
            ToolbarItem(placement: .principal) {
                Text(Localizable.register.stringKey)
                    .font(.sfProDisplay(size: .navTitleSize))
                    .foregroundStyle(Color.indigoPurple)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
        .toolbarBackground(
            Color.gray.opacity(Constants.toolbarBackgroundOpacity),
            for: .navigationBar
        )
    }
}

#Preview {
    NavigationStack {
        RegisterView(store: Store(initialState: RegisterReducer.State()) {
            RegisterReducer()
        })
    }
}
