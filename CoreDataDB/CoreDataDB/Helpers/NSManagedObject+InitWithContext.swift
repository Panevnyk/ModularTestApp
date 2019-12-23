//
//  NSManagedObject+InitWithContext.swift
//  CoreDataDB
//
//  Created by Vladyslav Panevnyk on 23.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import CoreData

extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
