//
//  APIClientDependency.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/22/25.
//

import ComposableArchitecture

extension APIClient: DependencyKey {
    public static var liveValue: Self {
        APIClient()
    }
    public static let previewValue = Self()
    public static let testValue = Self()
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
