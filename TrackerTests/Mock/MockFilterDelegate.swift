//
//  MockFilterDelegate.swift
//  TrackerTests
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import Foundation
@testable import Tracker

final class MockFilterDelegate: FilterDelegateProtocol {
    var currentFilter: Filters = .allTrackers
    
    func didSelectFilter(filter: Filters) {
        
    }
    
    
}
