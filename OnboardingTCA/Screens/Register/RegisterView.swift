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
                        .font(.custom("Helvetica Neue", size: 18))
                        .foregroundStyle(Color.indigoBlue.opacity(0.8))
                        .padding(.bottom, 20)
                    TextField(.empty, text: $store.fullName)
                        .validationTextField(
                            label: Localizable.fullName.stringKey,
                            error: store.fullName.isValidName ? nil : .empty,
                            isNotEmpty: !store.fullName.isEmpty
                        )
                        .autocapitalization(.words)
                        .keyboardType(.namePhonePad)
                        .disableAutocorrection(true)
                    TextField(.empty, text: $store.email)
                        .validationTextField(
                            label: Localizable.email.stringKey,
                            error: store.email.isValidEmail ? nil : .empty,
                            isNotEmpty: !store.email.isEmpty
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    SecureField(.empty, text: $store.password)
                        .validationTextField(
                            label: Localizable.password.stringKey,
                            error: store.password.isValidPassword ? nil : .empty,
                            isNotEmpty: !store.password.isEmpty
                        )
                    Button {
                        store.send(.onClickSendButton)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.indigoBlue.opacity(0.8),
                                            Color.indigoPurple.opacity(0.8)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            Text(Localizable.send.stringKey)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                        .frame(height: 50)
                    }
                    .padding(.top, 20)
                    Spacer()
                }
                .padding(.bottom, 20)
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
                        Image(systemName: "arrow.left")
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
                    .font(.custom("SF Pro Display", size: 28))
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
