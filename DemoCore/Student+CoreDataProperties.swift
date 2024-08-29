//
//  Student+CoreDataProperties.swift
//  DemoCore
//
//  Created by Saumil on 24/07/24.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var mobile: String?
    @NSManaged public var imgName: String?

}

extension Student : Identifiable {

}
