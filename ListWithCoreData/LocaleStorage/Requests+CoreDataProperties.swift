//
//  Requests+CoreDataProperties.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 24.09.2022.
//

import CoreData
import Foundation

extension Requests {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Requests> {
        return NSFetchRequest<Requests>(entityName: "Requests")
    }
    
    @NSManaged public var requestBody: Data?
    @NSManaged public var responseBody: Data?
    @NSManaged public var identifier: String?
    @NSManaged public var lastUpdated: Date?
}

extension Requests: Identifiable {
    
    public var id: String {
        guard let identifier = identifier else {
            /// Log it to the crashlytics
            return UUID().uuidString
        }
        
        return identifier
    }
}
