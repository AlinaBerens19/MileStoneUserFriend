//
//  Friends+CoreDataProperties.swift
//  MileStoneUserFriend
//
//  Created by Aлександр Шаталов on 13/10/2021.
//
//

import Foundation
import CoreData


extension Friends {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: Users?

}

extension Friends : Identifiable {

}
