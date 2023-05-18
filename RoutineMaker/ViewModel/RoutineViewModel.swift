//
//  RoutineViewModel.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import Foundation

class RoutineViewModel: ObservableObject {
    @Published var addNewRoutine: Bool = false
    @Published var title: String = ""
    @Published var weekDays: [String] = []
    @Published var dayColor: String = "Card-1"
    @Published var isReminderOn: Bool = false
    @Published var reminderDate: Date = dateDefault
    @Published var reminderText: String = ""
    
    static var dateDefault: Date {
        let components = DateComponents(hour: 8, minute: 0)
            return Calendar.current.date(from: components) ?? Date()
    }
    
}
