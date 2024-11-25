//
//  Tracker.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit

struct Tracker: Equatable {
    let id: UUID
    let name: String
    let color: TrackerColor
    let emoji: Emoji
    let date: Date
    let schedule: WeekDays?
    
    
    static func == (lhs: Tracker, rhs: Tracker) -> Bool {
        return lhs.id == rhs.id
    }
}
