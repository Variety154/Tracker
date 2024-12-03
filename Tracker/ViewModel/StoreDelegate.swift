//
//  Binding.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 28.11.2024.
//

typealias Binding<T> = (T) -> Void

protocol StoreDelegate: AnyObject {
    func storeDidUpdate()
}
