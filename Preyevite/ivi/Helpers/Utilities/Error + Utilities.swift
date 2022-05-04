//
//  Error + Utilities.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import Foundation

extension NSError {
    static func standardErrorWithString(errorString: String) -> NSError {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: [NSLocalizedDescriptionKey : errorString])
    }
    
    static func standardNoDataError() -> NSError {
        return NSError.standardErrorWithString(errorString: "No data was returned.")
    }
}
