//
//  UtilitiesAndExtentions.swift
//  MyNewsReader
//
//  Created by Himanshu T on 15/4/21.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
}

extension DateFormatter {

    static func designedDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d, yyyy hh:mm a"
        return formatter
    }
    
}
