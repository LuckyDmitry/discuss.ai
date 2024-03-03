//
//  ProfileWorker.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 19/10/2023.
//

import Foundation

final class ProfileWorker {
  
  func calculateWeekdayStreak(registrationTime: TimeInterval, sessions: [SpeakingSession], todayDate: Date = Date()) -> [ProfileState.UserInfo.WeekdayStreak] {
    let today = Calendar.current.startOfDay(for: todayDate)
    let sortedSessions = sessions.sorted { $0.startGMT < $1.startGMT }
    
    var streaks = [Date: ProfileState.UserInfo.WeekdayStreak]()
    
    for session in sortedSessions {
      let sessionDate = Date(timeIntervalSince1970: session.startGMT)
      let sessionEndDate = sessionDate.addingTimeInterval(session.duration)
      let sessionStartDate = Calendar.current.startOfDay(for: sessionDate)
      
      if sessionEndDate < today {
        streaks[sessionStartDate] = .completed
      } else if sessionDate >= today {
        streaks[sessionStartDate] = .completed
      }
    }
    
    var currentDate = today
    for _ in (0...7) {
      let startOfDate = Calendar.current.startOfDay(for: currentDate)
      if streaks[startOfDate] == nil {
        streaks[startOfDate] = .missed
      }
      currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
    }
    
    let daysUntilWeek = (0...daysUntilEndOfWeek()).map { _ in ProfileState.UserInfo.WeekdayStreak.clear }
    let sortedStreaks = streaks.sorted(by: { $0.key.timeIntervalSince1970 > $1.key.timeIntervalSince1970} ).map { $0.value }
    
    return (sortedStreaks + daysUntilWeek).suffix(7)
  }
  
  func calculateLongestStreak(sessions: [SpeakingSession]) -> Int {
    
    let sortedSessions = sessions.sorted { $0.startGMT < $1.startGMT }
    
    var currentStreak = 0
    var longestStreak = 0
    var previousSessionDate: Date?
    for session in sortedSessions {
      let sessionDate = Date(timeIntervalSince1970: session.startGMT)
      
      if let previousDate = previousSessionDate {
        let calendar = Calendar.current
        if !calendar.isDate(sessionDate, inSameDayAs: previousDate) && isDateTomorrow(firstDate: previousDate, secondDate: sessionDate) {
          currentStreak += 1
        } else {
          currentStreak = 1
        }
      } else {
        currentStreak = 1
      }
      
      if currentStreak > longestStreak {
        longestStreak = currentStreak
      }
      
      previousSessionDate = sessionDate
    }
    
    return longestStreak
  }
  
  func datesForCurrentWeek() -> [Date] {
    var calendar = Calendar.current
    calendar.firstWeekday = 2 // Monday is considered the first day of the week
    
    let currentDate = Date()
    let today = calendar.startOfDay(for: currentDate)
    
    // Calculate the start of the week (Monday) by adjusting the weekday components
    let weekdayComponent = calendar.component(.weekday, from: today)
    let daysToSubtract = (weekdayComponent - calendar.firstWeekday + 7) % 7
    let startOfWeek = calendar.date(byAdding: .day, value: -daysToSubtract, to: today)!
    
    var dates = [Date]()
    
    for i in 0..<7 {
      if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
        dates.append(date)
      }
    }
    
    return dates
  }
  
  func daysUntilEndOfWeek() -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    
    // Determine the current day of the week (0 for Sunday, 1 for Monday, etc.)
    let currentDayOfWeek = calendar.component(.weekday, from: currentDate)
    
    // Calculate the number of days remaining in the week
    let daysRemaining = 7 - currentDayOfWeek
    
    return daysRemaining
  }
}
