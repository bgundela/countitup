//
//  Person.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/7/20.
//

import Foundation
import SwiftUI
import CoreData

class Person: NSManagedObject, Identifiable {
    @NSManaged public var name: String
    @NSManaged public var points: Int
    @NSManaged public var image: Data?
    @NSManaged public var history: String
}

extension Person {
    static func getAllPeople() -> NSFetchRequest<Person> {
        let request: NSFetchRequest<Person> = Person.fetchRequest() as! NSFetchRequest<Person>
        
        let sortDescriptors = [NSSortDescriptor]()
        
        request.sortDescriptors = sortDescriptors
        
        return request
    }
}
