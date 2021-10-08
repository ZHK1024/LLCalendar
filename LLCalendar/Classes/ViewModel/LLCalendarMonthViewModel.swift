//
//  LLCalendarMonthViewModel.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import Foundation

open class LLCalendarMonthViewModel {
    
    var calendar: [LLCalendar.Month] = []
    
    public init() {
        try? initDataCalendar()
    }
    
    private func initDataCalendar() throws {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        guard var firstDate = calendar.date(from: DateComponents(year: year)) else {
            return
        }
//        print(firstDate)
//        
        let formatter = DateFormatter()
//
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEEE"
        
        var months: [LLCalendar.Month] = []

        calendar.range(of: .month, in: .year, for: firstDate)?.forEach({ month in
            var days: [LLCalendar.Day] = []
            let weekday = calendar.component(.weekday, from: firstDate) - 1
            
            print(formatter.string(from: firstDate), weekday)
            
            calendar.range(of: .day, in: .month, for: firstDate)?.forEach({ day in
                days.append(LLCalendar.Day(name: "\(calendar.component(.day, from: firstDate))"))
                firstDate.addTimeInterval(3600 * 24)
            })
            months.append(LLCalendar.Month(offset: weekday, days: days))
        })
        
        self.calendar = months
    }
    
    static let CanendarPath = NSHomeDirectory() + "/Library/LLCalendar/\(Date().year())"
}

extension Date {
    
    public func year() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
}
