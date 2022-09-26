//
//  ListWithCoreDataApp.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

@main
struct ListWithCoreDataApp: App {
    
    // MARK: - Properties
    
    let persistenceController = PersistenceController.shared
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            PostsView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
    }
}
