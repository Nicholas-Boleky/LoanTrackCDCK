//
//  LoanTrackCDCKApp.swift
//  Shared
//
//  Created by Nicholas Boleky on 9/24/21.
//

import SwiftUI

@main
struct LoanTrackCDCKApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoansView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
