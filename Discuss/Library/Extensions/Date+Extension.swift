//
//  Date+Extension.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 02.07.2023.
//

import Foundation

func isTimeIntervalWithinCurrentDay(_ timeInterval: TimeInterval) -> Bool {
    let calendar = Calendar.current
    let now = Date()
    
    // Get the start and end of the current day
    let startOfDay = calendar.startOfDay(for: now)
    let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: now)!
    
    // Check if the timeInterval falls within the current day
    let dateWithTimeInterval = Date(timeIntervalSince1970: timeInterval)
    return dateWithTimeInterval >= startOfDay && dateWithTimeInterval <= endOfDay
}

func isTimeIntervalWithinCurrentWeek(_ timeInterval: TimeInterval) -> Bool {
    let calendar = Calendar.current
    let now = Date()
    
    // Get the start of the current week
    let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))
    
    // Get the end of the current week
    let endOfWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek!)!
        .addingTimeInterval(-1)
    
    // Check if the timeInterval falls within the current week
    let dateWithTimeInterval = Date(timeIntervalSince1970: timeInterval)
    return dateWithTimeInterval >= startOfWeek! && dateWithTimeInterval <= endOfWeek
}

func isDateTomorrow(firstDate: Date, secondDate: Date) -> Bool {
    let calendar = Calendar.current
    let currentDate = calendar.startOfDay(for: firstDate)
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: currentDate)!
    
    return calendar.isDate(secondDate, inSameDayAs: tomorrow)
}
