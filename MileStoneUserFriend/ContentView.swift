//
//  ContentView.swift
//  MileStoneUserFriend
//
//  Created by Aлександр Шаталов on 10/10/2021.
//

import CoreData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(entity: Users.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Users.name, ascending: true),
        NSSortDescriptor(keyPath: \Users.company, ascending: true)
    ]) var items: FetchedResults<Users>
    
    @State private var results = [User]()
    @State var editMode = EditMode.inactive
    @State var selection = Set<String>()
    
    init() {
        loadData()
    }
    
    private var editButton: some View {
        if editMode == .inactive {
            return Button(action: {
                self.editMode = .active
                self.selection = Set<String>()
            }) {
                Text("Edit")
            }
        }
        else {
            return Button(action: {
                self.editMode = .inactive
                self.selection = Set<String>()
            }) {
                Text("Done")
            }
        }
    }
    
    private var deleteButton: some View {
        if editMode == .inactive {
            return Button(action: {}) {
                Image(systemName: "")
            }
        } else {
            return Button(action: deleteUsers) {
                Image(systemName: "trash")
            }
        }
    }
    
    private func deleteUsers() {

    }
    
    var body: some View {
        NavigationView {
        VStack {
            List(selection: $selection) {
            ForEach(items, id: \.self) { user in
                VStack(alignment: .leading) {
                    NavigationLink(destination: DetailView(name: user.wrappedName, email: user.wrappedEmail, age: user.age, company: user.wrappedCompany, about: user.wrappedAbout, registered: user.wrappedDate, address: user.wrappedAddress, isActive: user.isActive, id: user.wrappedId)) {
                    Text((user.name) ?? "Unknown")
                        .font(.headline)
                 }
             }
        }
       .onDelete(perform: deleteUser)
                
        }
            
            Spacer()
            
            Button("Add users") {
                saveData()
            }
        }
        .navigationBarItems(leading: deleteButton, trailing: editButton)
        .environment(\.editMode, self.$editMode)
        }
    }
    
    func deleteUser(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let user = items[offset]

            // delete it from the context
            moc.delete(user)
        }

        // save the context
        try? moc.save()
    }
    
    func saveData() {

    for result in results {
        
            var item = Users(context: self.moc)
            
            item.id = result.id
            item.about = result.about
            item.address = result.address
            item.company = result.company
            item.name = result.name
            item.age = result.age
            item.isActive = result.isActive
            item.registered = result.registered
            item.email = result.email
            
            for friend in result.friends {
                item.friend?.id = friend.id
                item.friend?.name = friend.name
            }
            print(item)
            try? self.moc.save()
        }
  }
    
    func loadData() {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) {data, response, error in
                if let data = data {
                    //pull out the declaration of the decoder object
                    let decoder = JSONDecoder()
                    //set how we want to interpret dates in the JSON
                    decoder.dateDecodingStrategy = .iso8601
                    //decode directly to an array of User structs rather than a Response
                    if let decodedResponse = try?
                                        decoder.decode([User].self, from: data) {
                                        DispatchQueue.main.async {
                                            //decodedResponse is now [User] rather than Response.User
                                            self.results = decodedResponse
                                        }
                                        return
                                    }
                                }
                                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")

                            }.resume()
                        }
                    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}












