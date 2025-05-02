//
//  String.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/2/25.
//

import Foundation

public extension String {
    /// A Boolean value indicating that a string has characters.
    var isNotEmpty: Bool {
        !isEmpty
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
