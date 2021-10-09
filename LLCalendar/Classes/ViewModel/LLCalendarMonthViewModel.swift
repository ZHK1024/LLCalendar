//
//  LLCalendarMonthViewModel.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import Foundation
import LLGeneral

open class LLCalendarMonthViewModel {
    
    var calendar: [LLCalendar.Month] = []
    
    public init() {
        try? initDataCalendar()
    }
    
    private func initDataCalendar() throws {
        
        
        let calendar = Calendar.current
        let chineseCalendar = Calendar(identifier: .chinese)
        let year = calendar.component(.year, from: Date())
        guard var firstDate = calendar.date(from: DateComponents(year: year)) else {
            return
        }

        /// 计算每个月日期数据
        var months: [LLCalendar.Month] = []
        calendar.range(of: .month, in: .year, for: firstDate)?.forEach({ month in
            var days: [LLCalendar.Day] = []
            let weekday = calendar.component(.weekday, from: firstDate) - 1
            calendar.range(of: .day, in: .month, for: firstDate)?.forEach({ day in
                days.append(LLCalendar.Day(gregorian: "\(calendar.component(.day, from: firstDate))",
                                           chinese: chineseDay(calendar: chineseCalendar, date: firstDate)))
                /// 增加一天 `86400 = 3600 * 24`
                firstDate.addTimeInterval(86400)
            })
            months.append(LLCalendar.Month(offset: weekday, days: days))
        })
        self.calendar = months
    }
    
    private func chineseDay(calendar: Calendar, date: Date) -> String {
        let day = calendar.component(.day, from: date)
        if day == 1 {
            let month = calendar.component(.month, from: date)
            return Self.chineseMonth[month]
        }
        return "\(Self.chineseDay[day])"
    }
    
    @SourceDecodable(.plist, .mainBundle , "/ChineseDays.plist", [])
    static var chineseDay: [String]
    
    @SourceDecodable(.plist, .mainBundle , "/ChineseMonth.plist", [])
    static var chineseMonth: [String]
}
