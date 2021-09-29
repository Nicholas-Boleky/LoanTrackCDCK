//
//  Persistence.swift
//  Shared
//
//  Created by Nicholas Boleky on 9/24/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "LoanTrackCDCK")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        //add save to cloud
    }//end of init
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving to CoreData: ", error.localizedDescription)
        }
    }
    
}
