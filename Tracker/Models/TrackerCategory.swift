//
//  TrackerCategory.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import Foundation

struct TrackerCategory {
    let title: String
    let trackers: [Tracker]?
    
    init(title: String, trackers: [Tracker]? = nil) {
        self.title = title
        self.trackers = trackers
    }
    
}
