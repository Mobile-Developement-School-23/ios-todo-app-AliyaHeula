//
//  Date+extension.swift
//  ToDoList
//
//  Created by Aliya on 13.07.2023.
//

import Foundation


private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}()

extension Date {
    var dateTimeString: String { dateFormatter.string(from: self) }
}
