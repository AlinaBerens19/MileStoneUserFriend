//
//  Users+CoreDataProperties.swift
//  MileStoneUserFriend
//
//  Created by Aлександр Шаталов on 13/10/2021.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friend: Friends?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var wrappedId: String {
        id ?? "No id"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var wrappedAbout: String {
        about ?? "No information"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown email"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    
    public var wrappedDate: Date {
        registered ?? Date()
    }

}

extension Users : Identifiable {

}
