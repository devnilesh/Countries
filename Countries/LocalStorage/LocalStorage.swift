
import UIKit
import CoreData

class LocalStorage: NSObject {
    
    static let modelName    = "Countries"
    static let storeName    = "Countries.sqlite"
    
    static var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    static var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle(for: LocalStorage.self).url(forResource: LocalStorage.modelName, withExtension: "momd")! // type your database name here..
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    static var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent(LocalStorage.storeName)
        var failureReason = "There was an error creating or loading the application's saved data."
        let options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber(value: true as Bool), NSInferMappingModelAutomaticallyOption: NSNumber(value: true as Bool)]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "LocalStorage", code: 9999, userInfo: dict)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        }
        
        return coordinator
    }()
    
    static private var mainThreadContext: NSManagedObjectContext = {
        // Returns the main thread managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSOverwriteMergePolicy
        return managedObjectContext
    }()
    
    static private func backgroundThreadContext() -> NSManagedObjectContext{
        // Returns the background object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        // parent thread shall always be main thread.
        managedObjectContext.parent = mainThreadContext
        //        managedObjectContext.mergePolicy = NSOverwriteMergePolicy
        return managedObjectContext
    }
    
    static public func managedObjectContext() -> NSManagedObjectContext{
        
        if(Thread.isMainThread)
        {
            return self.mainThreadContext
        }
        else
        {
            return self.backgroundThreadContext()
        }
    }
    
    static func saveContext(context: NSManagedObjectContext, saveParent: Bool) throws{
        
        var contextError : NSError?
        
        LocalStorage.persistentStoreCoordinator.performAndWait {
            do {
                if context.hasChanges {
                    try context.save()
                }
            }
            catch {
                contextError = error as NSError
            }
            
            if(saveParent){
                
                if let parentContext = context.parent{
                    
                    do {
                        if parentContext.hasChanges {
                            try parentContext.save()
                        }
                    }
                    catch {
                        contextError = error as NSError
                    }
                }
            }
        }
        if contextError != nil {
            throw contextError!
        }
    }
    
    static func clearDataFor(entity: String) throws {
        let context = LocalStorage.mainThreadContext
        var removeError : NSError?
        context.performAndWait {
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            do {
                try context.execute(request)
                if context.hasChanges {
                    try context.save()
                }
            }
            catch {
                removeError = error as NSError
            }
        }
        
        if removeError != nil {
            throw removeError!
        }
    }
}
