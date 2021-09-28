//
//  CoreDataManager.swift
//  Core
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import CoreData
import UIKit

public class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    public init() {}
    
    let identifier: String  = "asd.Core"
    let model: String       = "GamesRxSwift"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func updateDataList(listSelected selected: Bool, withIndex index: Int) -> ListGame? {
        let timeStamp = Date().currentTimeMillis()
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListGame")
        
        do {
            let gamess = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = gamess[index]
            objectUpdate.setValue(selected, forKey: "favourite")
            objectUpdate.setValue(timeStamp, forKey: "timeStamp")
            
            do {
                try managedContext.save()
                return objectUpdate as? ListGame
            } catch {
                print(error)
                return nil
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func insertGameList(insertList withData: ListResultGame) -> ListGame? {
        
        let timestamp = Date().currentTimeMillis()
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ListGame", in: managedContext)!
        
        let games = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        games.setValue(withData.name, forKeyPath: "name")
        games.setValue(withData.id, forKeyPath: "id")
        games.setValue(withData.rating, forKey: "rating")
        games.setValue(withData.released, forKey: "released")
        games.setValue(false, forKey: "favourite")
        games.setValue(withData.backgroundImage, forKey: "imageList")
        games.setValue(timestamp, forKey: "timeStamp")
        
        do {
            try managedContext.save()
            return games as? ListGame
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func fetchAllGames() -> [ListGame]?{
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListGame")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [ListGame]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func fetchAllGamesFavourite() -> [ListGame]?{
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListGame")
        fetchRequest.predicate = NSPredicate(format: "favourite = %d", true)
        let sectionSortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [ListGame]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func updateDataListFavourite(listSelected selected: Bool, withIndex index: Int) -> ListGame? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListGame")
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: index))
        
        do {
            let gamess = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = gamess[0]
            
            objectUpdate.setValue(selected, forKey: "favourite")
            
            do {
                try managedContext.save()
                return objectUpdate as? ListGame
            } catch {
                print(error)
                return nil
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
