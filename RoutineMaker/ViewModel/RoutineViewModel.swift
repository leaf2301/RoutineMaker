//
//  RoutineViewModel.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import Foundation
import CoreData
import UserNotifications

class RoutineViewModel: ObservableObject {
    @Published var addNewRoutine: Bool = false
    @Published var title: String = ""
    @Published var weekDays: [String] = []
    @Published var dayColor: String = "Card-1"
    @Published var isReminderOn: Bool = false
    @Published var reminderDate: Date = dateDefault
    @Published var reminderText: String = ""
    
    @Published var isShowingTime: Bool = false
    @Published var editRoutine: Routine?
    static var dateDefault: Date {
        let components = DateComponents(hour: 8, minute: 0)
            return Calendar.current.date(from: components) ?? Date()
    }
    
    
    
    func addRoutine(context: NSManagedObjectContext) async -> Bool {
        var newRoutine: Routine!
        if let editRoutine = editRoutine {
            newRoutine = editRoutine
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: editRoutine.notificationIDs ?? [])
        } else {
            newRoutine = Routine(context: context)
        }
        
        newRoutine.title = title
        newRoutine.weekDays = weekDays
        newRoutine.color = dayColor
        newRoutine.isReminderOn = isReminderOn
        newRoutine.reminderText = reminderText
        newRoutine.notificationDate = reminderDate
        newRoutine.notificationIDs = []
        
        if isReminderOn {
            if let ids = try? await scheduleLocalNotifi() {
                newRoutine.notificationIDs = ids
                try? context.save()
                return true
            }
        } else {
            try? context.save()
            return true
        }
        
        
        return false
        
    }
    
    func scheduleLocalNotifi() async throws -> [String] {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.subtitle = reminderText
        content.sound = .default
        
        var notificationIds: [String] = []
        
        let weekdaySymbols: [String] = Calendar.current.weekdaySymbols
        
        for weekDay in weekDays {
            let id = UUID().uuidString
            let hour = Calendar.current.component(.hour, from: reminderDate)
            let min = Calendar.current.component(.minute, from: reminderDate)
            
            let day = weekdaySymbols.firstIndex { $0 == weekDay } ?? -1
            
            if day != -1 {
                let components = DateComponents(hour: hour, minute: min, weekday: (day+1))
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                try await UNUserNotificationCenter.current().add(request)
                
                notificationIds.append(id)
            }
        }
        return notificationIds
    }
    
    func resetData() {
        title = ""
        dayColor = "Card-1"
        weekDays = []
        isReminderOn = false
        reminderText = ""
        reminderDate = RoutineViewModel.dateDefault
        editRoutine = nil
    }
    
    func doneStatus() -> Bool {
        let reminderStatus = isReminderOn ? reminderText == "" : false
        
        if title == "" || weekDays.isEmpty || reminderStatus {
            return false
        }
        
        return true
    }
    
    func restoreEditData() {
        if let editRoutine = editRoutine {
            title = editRoutine.title ?? "Test"
            dayColor = editRoutine.color ?? "Card-1"
            weekDays = editRoutine.weekDays ?? []
            isReminderOn = editRoutine.isReminderOn
            reminderText = editRoutine.reminderText ?? "Test"
            reminderDate = editRoutine.notificationDate ?? RoutineViewModel.dateDefault
            
        }
    }
    
    func deleteRoutine(context: NSManagedObjectContext) -> Bool {
        if let editRoutine = editRoutine {
            context.delete(editRoutine)
            try? context.save()
            return true
        }
        return false
    }
    
    
}
