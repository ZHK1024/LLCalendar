//
//  LLCalendar.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import Foundation
import LLGeneral

/// 日历对象
public struct LLCalendar {
    
    /// 农历日期符号数组
    @SourceDecodable(.plist, .mainBundle , "/ChineseDays.plist", [])
    static var chineseDay: [String]
    
    /// 农历月份符号数组
    @SourceDecodable(.plist, .mainBundle , "/ChineseMonth.plist", [])
    static var chineseMonth: [String]
    
    /// 中国节日数组
    @SourceDecodable(.plist, .mainBundle, "/ChineseFestival.plist", [])
    static private var chineseFestival: [Festival]
    
    static let festival: [Festival] = {
        chineseFestival.map {
            guard $0.chinese else { return $0 }
            return try! $0.transform(to: .gregorian)
        }
    }()
}

extension LLCalendar {
    
    public func calculate() {
        
    }
    
    public static func makeCalendarData(year: Int) throws {
        /// 公历
        let calendar = Calendar.current
        /// 农历
        let chineseCalendar = Calendar(identifier: .chinese)
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
        
        print(LLCalendar.festival)
        let set = LLCalendar.festival.reduce(into: [String:Festival]()) {
//            guard let fest = $1.chinese ? try? $1.transform(to: .gregorian) : $1 else { return }
            $0["\($1.month)-\($1.day)"] = $1
        }
        print(set)
    }
    
    private static func chineseDay(calendar: Calendar, date: Date) -> String {
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        if day == 1 {
            return LLCalendar.chineseMonth[month]
        }
        return "\(LLCalendar.chineseDay[day])"
    }
}

extension LLCalendar {
    
    struct Year: Codable {
        
        let months: [Month]
    }
}

extension LLCalendar {
    
    struct Month: Codable {
        
        
        /// 日期偏移 (每月 1 号前面空白日期格数)
        /// 如下, 此处偏移为 4
        /*
         日  一  二  三  四   五  六
         -------------------------
                        1   2   3
         */
        let offset: Int
        
        /// 日期数组
        let days: [Day]
        
        /// 本月总格数 (空白格 + 日期数)
        var count: Int { offset + days.count }
    }
}

extension LLCalendar {
    
    struct Day: Codable {
        
        /// 公历
        let gregorian: String
        
        /// 农历
        let chinese: String
    }
    
    /// 日期标签
    enum Tag {
        case none   /// 无标签
        case work   /// 上班
        case rest   /// 休息
    }
}


extension LLCalendar {
    
    /// 节日
    struct Festival: Decodable {
        
        /// 月
        let month: Int
        
        /// 日
        let day: Int
        
        /// 节日名称
        let name: String
        
        /// 是否是农历
        let chinese: Bool
        
        // MARK: - Init
        
        init(month: Int, day: Int, name: String, chinese: Bool = false) {
            self.month = month
            self.day = day
            self.name = name
            self.chinese = chinese
        }
        
        /// 转换日期并生成新的对象
        /// - Parameter type: 转换的目标类型
        /// - Returns: 新的节日对象
        public func transform(to type: `TransformType`) throws -> Self {
            switch type {
            case .chinese:
                return Festival(month: month, day: day, name: name, chinese: chinese)
            case .gregorian:
                let components = DateComponents(month: month, day: day)
                guard let date = Calendar(identifier: .chinese).date(from: components) else {
                    throw NSError(domain: "", code: -1, userInfo: [
                        NSLocalizedDescriptionKey : "日期初始化失败"
                    ])
                }
                return Festival(month: Calendar.current.component(.month, from: date),
                                day: Calendar.current.component(.day, from: date),
                                name: name,
                                chinese: chinese)
            }
            
        }
        
        /// 转换类型
        enum `TransformType` {
            case gregorian  /// 公历
            case chinese    /// 农历
        }
    }
}
