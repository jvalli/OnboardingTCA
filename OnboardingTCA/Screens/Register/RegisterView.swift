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
        static let mainViewPadding: CGFloat = 20
        static let textFieldSpace: CGFloat = 25
        static let iconArrowLeft: String = "arrow.left"
        static let headlineTextColorOpacity = 0.8
        static let headlineTextPadding: CGFloat = 20
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
                            error: store.fullName.isValidName ? nil : .empty,
                            isNotEmpty: store.fullName.isNotEmpty
                        )
                        .autocapitalization(.words)
                        .keyboardType(.namePhonePad)
                        .disableAutocorrection(true)
                    TextField(.empty, text: $store.email)
                        .validationTextField(
                            label: Localizable.email.stringKey,
                            error: store.email.isValidEmail ? nil : .empty,
                            isNotEmpty: store.email.isNotEmpty
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    SecureField(.empty, text: $store.password)
                        .validationTextField(
                            label: Localizable.password.stringKey,
                            error: store.password.isValidPassword ? nil : .empty,
                            isNotEmpty: store.password.isNotEmpty
                        )
                    Button(Localizable.send.stringKey) {
                        store.send(.onClickSendButton)
                    }
                    .buttonStyle(.label)
                    .padding(.top, 20)
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
                VStack {
                    Spacer()
                    Text(Localizable.error.stringKey)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            case .registered:
                VStack {
                    Spacer()
                    Text(Localizable.userRegistered.stringKey)
                        .foregroundColor(.mint)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
            
        }
        .padding(Constants.mainViewPadding)
        .background {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.gray.opacity(0.1),
                    Color.gray.opacity(0.3)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: Constants.iconArrowLeft)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundStyle(Color.gray.opacity(0.5))
                            .frame(width: 35, height: 8)
                            .clipped()
                            .padding([.vertical, .trailing], 10)
                    }
                }
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
        .toolbarBackground(Color.gray.opacity(0.1), for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        RegisterView(store: Store(initialState: RegisterReducer.State()) {
            RegisterReducer()
        })
    }
}
