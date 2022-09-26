//
//  LocaleStorage.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 24.09.2022.
//

import SwiftUI

class LocaleStorage {

    // MARK: - Properties
    
    static let shared = LocaleStorage()
    private init() { }
    
    // MARK: - Helper Function
   
}

/*
 private func deleteItems(offsets: IndexSet) {
     withAnimation {
         offsets.map { items[$0] }.forEach(viewContext.delete)

         do {
             try viewContext.save()
         } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
     }
 }
}
 */
