//
//  Date + Utilities.swift
//  ivi
//
//  Created by Samuel Wong on 24/4/22.
//

import Foundation

extension Date {
    var timeDayMonthYearReadableString: String {
        let dateFormat:DateFormatter = DateFormatter()
        let timeZone = TimeZone.current
        dateFormat.dateFormat = "h:mm a - dd MMM, yyyy"
        dateFormat.timeZone = timeZone
        
        return dateFormat.string(from: self)
    }
}
