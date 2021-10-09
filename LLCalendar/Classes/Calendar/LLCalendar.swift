//
//  LLCalendar.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import Foundation

public struct LLCalendar {
    
//    static let
}

extension LLCalendar {
    
    struct Month: Codable {
        
        let offset: Int
        
        let days: [Day]
        
        var count: Int { offset + days.count }
    }
    
    struct Day: Codable {
        
        let gregorian: String
        
        let chinese: String
        
    }
}
