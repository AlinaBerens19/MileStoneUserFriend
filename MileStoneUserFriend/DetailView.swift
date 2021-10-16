//
//  DetailView.swift
//  MileStoneUserFriend
//
//  Created by Aлександр Шаталов on 13/10/2021.
//

import SwiftUI

struct DetailView: View {
    
    var name: String = ""
    var email: String = ""
    var age: Int16 = 0
    var company: String = ""
    var about: String = ""
    var registered: Date = Date()
    var address: String = ""
    var isActive: Bool = false
    var id: String = ""
    var friends: [Friend]
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                Group {
                Text("User name: \(name)")
                Text("User email: \(email)")
                Text("User age: \(age)")
                Text("User address: \(address)")
                Text("Is active: \(isActive ? "YES": "NO")")
                Text("User company: \(company)")
                Text("User registered: \(registered)")
                Text("About user: \(about)")
                Text(userFriends())
                }.font(.body)
                }
            }
        }
    }
    
    func userFriends() -> String {
        var user_friend: String = "User friends: "
        
        for friend in friends {
           user_friend += " \(friend.name),"
        }
        
        return user_friend
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
