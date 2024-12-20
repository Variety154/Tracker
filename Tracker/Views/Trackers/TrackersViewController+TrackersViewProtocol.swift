//
//  TrackersViewController+TrackersViewProtocol.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import UIKit

protocol TrackersViewProtocol: AnyObject {
    func showNewHabitViewController()
    func showNewIrregularEventController()
}


extension TrackersViewController: TrackersViewProtocol {
    func showNewHabitViewController() {
        let newTrackerViewController = TrackerViewController()
        newTrackerViewController.selectedDate = selectedDate
        newTrackerViewController.eventType = .habit
        newTrackerViewController.delegate = viewModel
        newTrackerViewController.modalPresentationStyle = .pageSheet
        present(newTrackerViewController, animated: true, completion: nil)
    }
    
    func showNewIrregularEventController() {
        let newTrackerViewController = TrackerViewController()
        newTrackerViewController.selectedDate = selectedDate
        newTrackerViewController.eventType = .oneOff
        newTrackerViewController.delegate = viewModel
        newTrackerViewController.modalPresentationStyle = .pageSheet
        present(newTrackerViewController, animated: true, completion: nil)
    }
    
}
