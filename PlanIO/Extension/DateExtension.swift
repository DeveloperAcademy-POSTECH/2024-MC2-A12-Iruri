//
//  DateExtension.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/23/24.
//

import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        let calendar = Calendar.current
        self = calendar.date(from: components) ?? Date()
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
}
