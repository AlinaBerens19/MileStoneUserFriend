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
                }.font(.body)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
