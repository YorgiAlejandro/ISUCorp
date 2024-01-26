//
//  ISUCorpApp.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/22/24.
//

import SwiftUI

@main
struct ISUCorpApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
