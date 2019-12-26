//
//  CoreDataManager.swift
//  CoreDataDB
//
//  Created by Vladyslav Panevnyk on 20.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import CoreData
import BusinessLogic

protocol CoreDataServiceProtocol: AnyObject {
    func save<T>(object: T) where T: NSManagedObject
    func getEntities<T>() -> [T]? where T: NSManagedObject
}

public class CoreDataService {
    // MARK: - Properties
    private let containerName: String = "CoreDataModel"
    private let bundleResourcePath = "Frameworks/CoreDataDB.framework/CoreDataModel"
    private let bundleResourceType = "momd"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle.main
        let path = bundle.path(forResource: bundleResourcePath, ofType: bundleResourceType)!
        let url = URL(string: path)!
        let model = NSManagedObjectModel(contentsOf: url)!
        let persistentContainer = NSPersistentContainer(name: containerName, managedObjectModel: model)
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var persistentContainerQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    // MARK: - Init
    public init() {
        saveContext()
    }
    
    func saveContext() {
        let context = backgroundContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

// MARK: - CoreDataServiceProtocol
extension CoreDataService: CoreDataServiceProtocol {
    func save<T>(object: T) where T: NSManagedObject {
        writeBlock {
            _ = self.backgroundContext.addEntity(withType: T.self)
        }
    }
    
    func remove<T>(object: T) where T: NSManagedObject {
        writeBlock {
            self.backgroundContext.delete(object)
        }
    }
    
    func writeBlock(action: @escaping (() -> Void)) {
        persistentContainerQueue.addOperation { [weak self] in
            guard let self = self else { return }
            self.backgroundContext.performAndWait {
                action()
                guard self.backgroundContext.hasChanges else { return }
                do {
                    try self.backgroundContext.save()
                    self.backgroundContext.refreshAllObjects()
                } catch let error {
                    print("Error saving context: \(error)")
                }
            }
        }
    }
    
    func getEntities<T>() -> [T]? where T: NSManagedObject {
        do {
            let entities = try persistentContainer.viewContext.allEntities(withType: T.self)
            return entities
            
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
