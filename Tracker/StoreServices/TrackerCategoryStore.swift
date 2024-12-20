//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 22.11.2024.
//

import CoreData

enum TrackerCategoryStoreError: Error {
    case createCategoryError
    case decodeCategoryError
}

final class TrackerCategoryStore: BasicStore {
    
    weak var delegate: StoreDelegate?
    
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
                
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }()
    
    
    
    func addTrackerCategory(category : String) throws {
        if find(by: category) != nil {
            return
        }
        let trackerCategoryCoreData = TrackerCategoryCoreData(context: self.managedObjectContext)
        trackerCategoryCoreData.title = category
        try save()
    }
    
    func fetchTrackerCategories() throws -> [TrackerCategory] {
            guard
                let objects = self.fetchedResultsController.fetchedObjects,
                let trackerCategories = try? objects.map({try self.trackerCategory(from: $0)})
            else { return [] }
            return trackerCategories
        
    }
    
    private func find(by title: String) -> TrackerCategoryCoreData? {
        let fetchRequest: NSFetchRequest<TrackerCategoryCoreData> = TrackerCategoryCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        if let fetchedCategory = try? managedObjectContext.fetch(fetchRequest).first {
            return fetchedCategory
        }
        return nil
        
    }
    
    private func trackerCategory(from trackerCategoryCoreData: TrackerCategoryCoreData) throws -> TrackerCategory {
        guard let title = trackerCategoryCoreData.title
        else {
            throw TrackerCategoryStoreError.decodeCategoryError
        }
        
        return TrackerCategory(title: title)
    }
    
}

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.storeDidUpdate()
    }
}
