//
//  StoreDelegate.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 26.11.2024.
//

typealias Binding<T> = (T) -> Void

protocol StoreDelegate: AnyObject {
    func storeDidUpdate()
}
