//
//  LocaleStorage.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 24.09.2022.
//

import Foundation
import CoreData


class LocaleStorage {
    
    struct Request {
        let id: String
        let responseBody: Data?
        let requestBody: Data?
    }
    
    private let persistence = PersistenceController.shared
    private (set) var context = PersistenceController.shared.container.viewContext
    static let shared = LocaleStorage()
    private var entity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "Requests", in: context)
    }
    
    var requests: [Requests] {
        do {
            let results = try context.fetch(Requests.fetchRequest())
            return results
        } catch {
            return []
        }
    }
    
//    init(_ context: NSManagedObjectContext) {
//        self.context = context
//    }
    
    func save(request: Request) {
        guard let entity = entity else {
            /// Log it to the crashltics
            return
        }
        
        var dataRequest: Requests
        
        if let savedRequest = requests.first(where: {$0.id == request.id}) {
            dataRequest = savedRequest
        } else {
            dataRequest = Requests(entity: entity, insertInto: context)
        }
        
        dataRequest.identifier = request.id
        dataRequest.responseBody = request.responseBody
        dataRequest.requestBody = request.requestBody
        
        persistence.saveContext()
    }
    
    func get(withID id: String) -> Requests? {
        let fetchRequest = Requests.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier =[c] %@", id)
        do {
            let result = try context.fetch(fetchRequest)
            return result.last
        } catch {
            return nil
        }
    }
    
    func remove(withID id: String) {
        guard let objectToDelete = get(withID: id) else {
            debugPrint("Not found data")
            return
        }
        
        context.delete(objectToDelete)
        persistence.saveContext()
                
    }
}
