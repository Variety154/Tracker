//
//  BasicStore.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 22.11.2024.
//

import CoreData
import UIKit

class BasicStore: NSObject {
    private let context: NSManagedObjectContext
    
    override init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Не удалось получить AppDelegate")
        }
        
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
}

extension BasicStore {
    var managedObjectContext: NSManagedObjectContext {
        return context
    }
}
