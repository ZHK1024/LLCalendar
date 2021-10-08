//
//  Date.swift
//  Sediment
//
//  Created by ZHK on 2020/6/30.
//  Copyright © 2020 ZHK. All rights reserved.
//

import Foundation

/// 时间区间
typealias DateRange = (start: Date, end: Date)

public extension Date {
    
    enum Weekday: Int, CaseIterable {
        
        static let chineseWeakdaySymbols = ["日", "一", "二", "三", "四", "五", "六"]
        
        case Sunday = 0, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
        
        var symbol: String {
            Weekday.chineseWeakdaySymbols[rawValue]
        }
    }
}

public extension Date {
    
    /// MARK: Day
    
    /// 获取当月日期范围, 例如: `Range(1..<31)`
    /// - Parameter calender: 日历对象
    /// - Returns: 天数的 Range
    func daysRangeInMonth(calender: Calendar = Calendar.current) -> Range<Int> {
        calender.range(of: .day, in: .month, for: self)!
    }
    
    func monthsRangeInYear(calender: Calendar = Calendar.current) -> Range<Int> {
        calender.range(of: .month, in: .year, for: self)!
    }
    
    /// 计算当前日期在本月是第几天 day - 1
    /// - Parameter calender: 日历对象
    /// - Returns: 日期索引 `Range(0..<daysCount)`
    func dayIndexInTheMonth(calender: Calendar = Calendar.current) -> Int {
        guard let day = calender.dateComponents([.day], from: self).day else {
            return 0
        }
        return day - 1
    }
    
    /// MARK: Week
    
    /// 获取当前日期是星期几
    /// - Parameter calender: 日历对象
    /// - Returns: 星期日枚举
    func weekday(calender: Calendar = Calendar.current) -> Weekday {
        /// API 返回的星期日为 1~7 的数字, 因此需要 `-1`, 方便从符号数组获取对应的符号
        Weekday(rawValue: calender.component(.weekday, from: self) - 1)!
    }
    
    /// MARK: Month
    
    /// 获取当前日期所在月份的第一天的日期
    /// - Parameter calender: 日历对象
    /// - Returns: 日期对象
    func firstDayOfThisMonth(calender: Calendar = Calendar.current) -> Date {
        var components = calender.dateComponents([.year, .month], from: self)
        components.day = 1
        return calender.date(from: components)!
    }
    
    /// 下一个月的今天, 如果日期超出了当月最大天数, 取当月最后一天
    /// - Parameter calender: 日历对象
    /// - Returns: 返回一个新的日期对象或者 nil
    func nextMonth(calender: Calendar = Calendar.current) -> Date? {
        addMonth(calender: calender, value: 1)
    }
    
    /// 上一个月的今天, 如果日期超出了当月最大天数, 取当月最后一天
    /// - Parameter calender: 日历对象
    /// - Returns: 返回一个新的日期对象或者 nil
    func lastMonth(calender: Calendar = Calendar.current) -> Date? {
        addMonth(calender: calender, value: -1)
    }
    
    // MARK: Year
    
    /// 获取当前日期的年份
    /// - Parameter calender: 日历对象
    /// - Returns: 年份
    func year(calender:  Calendar = Calendar.current) -> Int {
        calender.dateComponents([.year], from: self).year ?? 0
    }
    
    /// 当前日期的年份
    /// - Parameter calender: 日历对象
    /// - Returns: 月份
    func month(calender:  Calendar = Calendar.current) -> Int {
        calender.dateComponents([.month], from: self).month ?? 0
    }
    
    func addMonth(calender: Calendar, value: Int) -> Date? {
        calender.date(byAdding: .month, value: value, to: self)
    }
}


public extension Date {
    
    func dateString(_ formatString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter.string(from: self)
    }
}
