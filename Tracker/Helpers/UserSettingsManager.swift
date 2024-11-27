//
//  UserSettingsManager.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 26.11.2024.
//

import Foundation

final class UserSettingsManager {
    
    static let shared = UserSettingsManager()
    
    var isOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: SettingsKey.isOnboarded.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: SettingsKey.isOnboarded.rawValue)
        }
    }
    
    private init() {}
    
    private enum SettingsKey: String {
        case isOnboarded
    }
    
    private let defaults = UserDefaults.standard
    
}
