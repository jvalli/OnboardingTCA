//
//  String.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/2/25.
//

import Foundation

private struct RegexPatterns {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    /// Allows letters, spaces, hyphens, and apostrophes
    static let name = "^[\\p{L}\\s'-]+$"
    // Regex pattern explanation:
    // ^                  - Start anchor
    // (?=.*[A-Z])       - At least one uppercase letter
    // (?=.*[a-z])       - At least one lowercase letter
    // (?=.*\\d)         - At least one digit
    // (?=.*[@$!%*?&])   - At least one special character
    // [A-Za-z\\d@$!%*?&]{8,} - At least 8 characters long
    // $                  - End anchor
    static let password = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
}

public extension String {
    /// A Boolean value indicating that a string has characters.
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    var isValidName: Bool {
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", RegexPatterns.name)
        return namePredicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", RegexPatterns.email)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", RegexPatterns.password)
        return namePredicate.evaluate(with: self)
    }
}

public extension StringProtocol where Self == String {
    /// An empty string: `""`
    static var empty: String { "" }

    /// A dot/period: `"."`
    static var dot: String { "." }

    /// A space: `" "`
    static var space: String { " " }

    /// A comma: `","`
    static var comma: String { "," }
}
