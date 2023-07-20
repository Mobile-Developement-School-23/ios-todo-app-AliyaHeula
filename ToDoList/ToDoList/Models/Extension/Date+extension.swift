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

private let dateFormatterShortRU: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.dateFormat = "d MMMM yyyy"
    return formatter
}()

extension Date {
    var dateTimeString: String { dateFormatter.string(from: self) }
    var dateStringShortRU: String { dateFormatterShortRU.string(from: self) }
}
