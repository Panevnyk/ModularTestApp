//
//  NSManagedObjectContext+HelperMethods.swift
//  CoreDataDB
//
//  Created by Vladyslav Panevnyk on 20.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import CoreData

protocol NSManagedObjectContextProtocol {
    func entity<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> T?
    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T]
    func allEntities<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T]
    func addEntity<T: NSManagedObject>(withType type: T.Type) -> T?
    func save() throws
    func reset()
    func refreshAllObjects()
    func delete(_ object: NSManagedObject)
    func deleteObjects<T: NSManagedObject>(withType type: T.Type) throws
    func performAndWait(_ block: () -> Swift.Void)
    func perform(_ block: @escaping () -> Swift.Void)
}

extension NSManagedObjectContext: NSManagedObjectContextProtocol {
    func entity<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> T? {
        let entityName: String = T.description()
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        let results: [T] = try self.fetch(request)

        return results.first
    }

    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T] {
        return try allEntities(withType: type, predicate: nil)
    }

    func allEntities<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T] {
        let entityName: String = T.description()
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        let results: [T] = try self.fetch(request)

        return results
    }

    func addEntity<T: NSManagedObject>(withType type: T.Type) -> T? {
        let entityName: String = T.description()
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self) else {
            return nil
        }
        let record: T = T(entity: entity, insertInto: self)

        return record
    }

    func deleteObjects<T: NSManagedObject>(withType type: T.Type) throws {
        let entityName: String = T.description()
        let deleteFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        try self.execute(deleteRequest)
    }
}
