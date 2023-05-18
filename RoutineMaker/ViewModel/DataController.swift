//
//  DataController.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "RoutineData")
    init() {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("CoreData failed to load data \(error.localizedDescription)")
            }
        }
    }
}

