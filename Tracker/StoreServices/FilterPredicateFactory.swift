//
//  FilterPredicateFactory.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import Foundation

enum PredicateType {
    case all
    case date(Date)
    case isPinned(Bool)
    case scheduled
    case oneOff
}

final class FilterPredicateFactory {
    
    static func makePredicate(for type: PredicateType) -> NSPredicate {
        switch type {
        case .all:
            return NSPredicate(value: true)
        case .date(let date):
            return trackersForDate(date: date)
        case .isPinned(let pinned):
            return NSPredicate(format: "isPinned == %@", NSNumber(value: pinned))
        case .scheduled:
            return NSPredicate(format: "schedule != 0 AND schedule != nil")
        case .oneOff:
            return NSPredicate(format: "schedule == 0 OR schedule == nil")
        }
    }
    
    // MARK: - Private Helper Methods
    private static func trackersForDate(date: Date) -> NSPredicate {
        let calendar = Calendar.current
        let currentWeekdayInt = calendar.component(.weekday, from: date)
        let currentWeekday = WeekDays.fromGregorianStyle(currentWeekdayInt)?.rawValue ?? 0
        let dateStart = date.startOfDay() as NSDate
        
        let datePredicate = NSPredicate(format: "date == %@", dateStart)
        let scheduleZeroPredicate = NSPredicate(format: "schedule == 0 OR schedule == nil")
        
        let dateAndNoSchedulePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, scheduleZeroPredicate])
        let scheduleContainsDayPredicate = NSPredicate(format: "(schedule & %d) != 0", currentWeekday)
        
        return NSCompoundPredicate(orPredicateWithSubpredicates: [dateAndNoSchedulePredicate, scheduleContainsDayPredicate])
    }
}
