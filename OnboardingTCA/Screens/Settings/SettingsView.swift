//
//  SettingsView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/30/25.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
    @Bindable var store: StoreOf<SettingsReducer>
    
    var body: some View {
        Text(Localizable.settings.stringKey)
    }
}

#Preview {
    SettingsView(store: Store(initialState: SettingsReducer.State()) {
        SettingsReducer()
    })
}
