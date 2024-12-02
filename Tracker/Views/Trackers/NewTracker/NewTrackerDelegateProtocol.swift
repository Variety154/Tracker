//
//  NewTrackerDelegateProtocol.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 22.11.2024.
//

import Foundation

protocol NewTrackerDelegateProtocol: AnyObject {
    func didSelectDays(_ selectedDays: WeekDays)
    func didSelectEmoji(_ indexPath: IndexPath)
    func didSelectColor(_ indexPath: IndexPath)
    func didSelectCategory(category: String)
}
