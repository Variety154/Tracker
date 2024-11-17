//
//  ScheduleDelegateProtocol.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

protocol ScheduleDelegateProtocol: AnyObject {
    func didSelectDays(_ selectedDays: [WeekDays])
}
