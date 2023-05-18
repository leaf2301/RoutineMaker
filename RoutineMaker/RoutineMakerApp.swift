//
//  RoutineMakerApp.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import SwiftUI

@main
struct RoutineMakerApp: App {
    @StateObject var dataController: DataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
