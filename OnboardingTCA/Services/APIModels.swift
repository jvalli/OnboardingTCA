//
//  APIModelsDependency.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/22/25.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case encodingFailed(innerError: EncodingError)
    case decodingFailed(innerError: DecodingError)
    case invalidStatusCode(statusCode: Int)
    case requestFailed(innerError: URLError)
    case otherError(innerError: Error)
}

struct RegisterPayload: Codable {
    let fullName: String
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
    }
}

struct RegisterResponse: Codable {
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case user = "insert_users_one"
    }
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
