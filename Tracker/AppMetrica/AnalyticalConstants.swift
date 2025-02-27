//
//  AnalyticalConstants.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

enum AnalyticsEvent: String {
    case open
    case close
    case click
}

enum Parameter: String {
    case screen
    case item
}

enum AnalyticsEventData {
    
    enum MainScreen {
        static let name = "Main"
        
        static let clickAddTracker: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "add_tracker"
        ]
        static let clickFilter: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "filter"
        ]
        static let clickEdit: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "edit"
        ]
        static let clickDelete: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "delete"
        ]
        static let clickTracker: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "track"
        ]
    }
    
    enum TrackersTypeScreen {
        static let name = "TrackersType"
        
        static let clickAddTracker: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "add_tracker"
        ]
        static let clickAddIrregularEvent: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "add_irregularEvent"
        ]
    }
    
    enum NewTrackerScreen {
        static let name = "NewTracker"
        
        static let clickSave: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "save"
        ]
        static let clickCancel: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "cancel"
        ]
    }
    
    enum FiltersScreen {
        static let name = "Filters"
        
        static let selectFilter: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "select_filter"
        ]
    }
    
    enum NewCategoryScreen {
        static let name = "NewCategory"
        
        static let clickCreate: [AnyHashable: Any] = [
            Parameter.screen.rawValue: name,
            Parameter.item.rawValue: "create"
        ]
    }
}
