//
//  APIClient.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 4/22/25.
//

import Foundation

protocol APIClientProtocol: Sendable {
    func signUp(fullName: String, email: String, password: String) async throws -> Result<User, ApiError>
}

struct APIClient: APIClientProtocol {
    var baseUrl: URL?
    
    struct Constants {
        static let jsonContentType = "application/json"
        static let invalidStatusCode = -1
        static let validStatusCodes = (200...299)
        
        struct Configs {
            static let apiUrl = "https://obliging-rattler-22.hasura.app/api/rest/"
            static let apiSecret = "BshQUntvZksF2OG8A7bzDq4qoKeRj400eRPPrtfNydYj2MrEVnJOzZUrLvVxdp1d"
            static let apiCreateUser = "createuser"
        }
    }
    
    init() {
        baseUrl = URL(string: Constants.Configs.apiUrl)
    }
    
    func signUp(fullName: String, email: String, password: String) async throws -> Result<User, ApiError> {
        do {
            guard let signInUrl = baseUrl?.appending(path: Constants.Configs.apiCreateUser) else {
                throw ApiError.invalidUrl
            }
            var request = URLRequest(url: signInUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.addValue(Constants.jsonContentType, forHTTPHeaderField: HTTPHeaderKey.contentType.rawValue)
            request.addValue(Constants.Configs.apiSecret, forHTTPHeaderField: HTTPHeaderKey.adminSecret.rawValue)
            let newUser = RegisterPayload(fullName: fullName, email: email, password: password)
            let jsonData = try JSONEncoder().encode(newUser)
            request.httpBody = jsonData
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse
            }
            guard Constants.validStatusCodes.contains(response.statusCode) else {
                throw ApiError.invalidStatusCode(statusCode: response.statusCode)
            }
            let reponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
            return .success(reponse.user)
        } catch let error as DecodingError {
            return .failure(.decodingFailed(innerError: error))
        } catch let error as EncodingError {
            return .failure(.encodingFailed(innerError: error))
        } catch let error as URLError {
            return .failure(.requestFailed(innerError: error))
        } catch let error as ApiError {
            return .failure(error)
        } catch {
            return .failure(.otherError(innerError: error))
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
}

struct HTTPHeaderKey: RawRepresentable, Sendable {
    public static let accept: HTTPHeaderKey = "Accept"
    public static let acceptLanguage: HTTPHeaderKey = "Accept-Language"
    public static let authorization: HTTPHeaderKey = "Authorization"
    public static let contentType: HTTPHeaderKey = "Content-Type"
    public static let userAgent: HTTPHeaderKey = "User-Agent"
    public static let adminSecret: HTTPHeaderKey = "x-hasura-admin-secret"

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension HTTPHeaderKey: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}
