//
//  CoreDataStack.swift
//  Novabooths
//
//  Created by Saumil on 27/02/23.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DemoCore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = self.persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Add array in local database")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData<T: NSManagedObject>(manageObject: T.Type) -> [T]? {
        do {
            if let requestData = try CoreDataStack.shared.context.fetch(manageObject.fetchRequest()) as? [T] {
                return requestData
            }
            return nil
        }catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

}

