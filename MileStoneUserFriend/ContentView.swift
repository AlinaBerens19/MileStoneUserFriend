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
    
    @State private var users = [User]()



    var body: some View {
        NavigationView {
            ZStack {
                
            List {
            ForEach(users, id: \.self) { user in
                VStack(alignment: .leading) {
                    NavigationLink(destination: DetailView(name: user.name, email: user.email, age: user.age, company: user.company, about: user.about, registered: user.registered, address: user.address, isActive: user.isActive, id: user.id, friends: user.friends)) {
                         Text(user.name)
                         .font(.headline)
                  }
               }
            }
            //.onDelete(perform: deleteUser)
            }
            .onAppear(perform: loadData)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func deleteUser(at offsets: IndexSet) {
         for offset in offsets {
             // find this book in our fetch request
             let user = items[offset]

             // delete it from the context
             moc.delete(user)
             // save the context
              try? moc.save()
          }
    }
    
    func saveData() {
     
        loadData()
        
        for result in users {

        let item = Users(context: self.moc)

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

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    //pull out the declaration of the decoder object
                    let decoder = JSONDecoder()
                    //set how we want to interpret dates in the JSON
                    decoder.dateDecodingStrategy = .iso8601
                    //decode directly to an array of User structs rather than a Response
                    do {
                        users = try decoder.decode([User].self, from: data)
                        //print(users.self)
                    }
                    catch DecodingError.keyNotFound(let key, let context) {
                          Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                      } catch DecodingError.valueNotFound(let type, let context) {
                          Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                      } catch DecodingError.typeMismatch(let type, let context) {
                          Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                      } catch DecodingError.dataCorrupted(let context) {
                          Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                      } catch let error as NSError {
                          NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                      }
                }
            }.resume()
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}












