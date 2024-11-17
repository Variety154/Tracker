//
//  Array+Extension.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
