//
//  TrackerRecord.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import Foundation

struct TrackerRecord: Hashable {
    let trackerId: UUID
    let date: Date
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trackerId)
        hasher.combine(Calendar.current.startOfDay(for: date))
    }
    
    static func == (lhs: TrackerRecord, rhs: TrackerRecord) -> Bool {
        return lhs.trackerId == rhs.trackerId &&
        Calendar.current.isDate(lhs.date, inSameDayAs: rhs.date)
    }
}
