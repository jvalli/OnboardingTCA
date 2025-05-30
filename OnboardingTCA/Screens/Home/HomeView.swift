//
//  HomeView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/27/25.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    @Bindable var store: StoreOf<HomeReducer>
    
    var body: some View {
        Text(Localizable.home.stringKey)
    }
}

#Preview {
    HomeView(store: Store(initialState: HomeReducer.State()) {
        HomeReducer()
    })
}
