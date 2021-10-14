//
//  User.swift
//  MileStoneUserFriend
//
//  Created by Aлександр Шаталов on 13/10/2021.
//

import Foundation


struct User: Codable {
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int16
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    let friends: [Friend]
    

}

struct Friend: Codable {
    
    var id: String
    var name: String
    
}
