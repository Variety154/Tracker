//
//  TrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import Foundation

protocol TrackersViewControllerProtocol {
    var currentDate: Date { get }
    
    func showNewHabitViewController()
    func showIrregularEventController()
    func didCreateNewTracker(tracker: Tracker)
    func didCreateTrackerRecord(tracker: Tracker, date: Date) -> Int
}
