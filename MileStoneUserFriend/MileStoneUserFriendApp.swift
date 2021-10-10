//
//  MileStoneUserFriendApp.swift
//  MileStoneUserFriend
//
//  Created by Aлександр Шаталов on 10/10/2021.
//

import SwiftUI

@main
struct MileStoneUserFriendApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
