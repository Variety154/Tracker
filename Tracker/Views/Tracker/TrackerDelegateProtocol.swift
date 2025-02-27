//
//  TrackerDelegateProtocol.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import Foundation

protocol TrackerDelegateProtocol: AnyObject {
    func didSelectDays(_ selectedDays: WeekDays)
    func didSelectEmoji(_ indexPath: IndexPath)
    func didSelectColor(_ indexPath: IndexPath)
    func didSelectCategory(category: String)
}
