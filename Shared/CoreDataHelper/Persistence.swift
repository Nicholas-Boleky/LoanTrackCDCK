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
    
    //Taking in loan ID To only display payments linked to specific loan
    func fetchPayments(for loanId: String) -> [Payment] {
        let request: NSFetchRequest<Payment> = Payment.fetchRequest()
        //Predicates are used to query specific values, '%@' is a placehodler from objC times that tells xcode to replace it with the variable. In other words this will search for payments with our needed loan id
        request.predicate = NSPredicate(format: "loanid == %@", loanId)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Payment.date, ascending: true)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
}//structfile
