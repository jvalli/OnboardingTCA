//
//  WelcomeView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/21/25.
//

import ComposableArchitecture
import SwiftUI

struct WelcomeView: View {
    let store: StoreOf<WelcomeReducer>
    
    @State var destination: Destination?
    
    struct Constants {
        static let mainViewPadding: CGFloat = 20
        static let textSpace: CGFloat = 30
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.gray.opacity(0.1),
                            Color.gray.opacity(0.3)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            VStack(spacing: Constants.textSpace) {
                Text(Localizable.onboardingTCAApp.stringKey)
                    .font(.custom("SF Pro Display", size: 32))
                    .foregroundStyle(Color.indigoPurple)
                Text(store.state.message)
                    .font(.custom("Helvetica Neue", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.indigoBlue.opacity(0.8))
                Button {
                    destination = .loginView
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
                        Text(Localizable.start.stringKey)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                    .frame(height: 50)
                }
            }
            .padding(Constants.mainViewPadding)
            .onAppear {
                store.send(.viewDidAppear)
            }
            .navigationDestination(item: $destination.loginView) {_ in
                RegisterView(store: .init(initialState: RegisterReducer.State()) {
                    RegisterReducer()
                })
            }
        }
        .ignoresSafeArea(.all)
    }
}

@CasePathable
enum Destination {
    case loginView
}

#Preview {
    NavigationStack {
        WelcomeView(store: .init(initialState: WelcomeReducer.State()) {
            WelcomeReducer()
        })
    }
}
