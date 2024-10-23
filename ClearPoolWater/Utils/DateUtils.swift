//
//  DateUtils.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Foundation

struct DateUtils {
    static func isToday(_ date: Date?) -> Bool {
        guard let date else { return false }
        return Calendar.current.isDateInToday(date)
    }

    static func isYesterday(_ date: Date?) -> Bool {
        guard let date else { return false }
        return Calendar.current.isDateInYesterday(date)
    }

    static func formatDate(_ date: Date?) -> String {
        if DateUtils.isToday(date) {
            return "Today"
        }
        if DateUtils.isYesterday(date) {
            return "Yesterday"
        }
        return date?.formatted(date: .numeric, time: .omitted) ?? "No Info"
    }
}
