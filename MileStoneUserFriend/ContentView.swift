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
            List(users, id: \.id) { user in
                Text("\(user.name)")
            }
            .onAppear(perform: loadData)
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












