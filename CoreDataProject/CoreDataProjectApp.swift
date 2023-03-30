//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Danjuma Nasiru on 04/02/2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
