//
//  CardView.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 20/05/2023.
//

import SwiftUI

struct CardView: View {
    @FetchRequest(entity: Routine.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Routine.dateAdded, ascending: false)], animation: .easeInOut) var routines: FetchedResults<Routine>
    @EnvironmentObject var vm: RoutineViewModel
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            ForEach(routines, id: \.self) { routine in
                VStack(spacing: 6) {
                    HStack {
                        Text(routine.title.defaultString)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                        Image(systemName: "bell.badge.fill")
                            .font(.callout)
                            .foregroundColor(Color(routine.color ?? "Card-1"))
                            .scaleEffect(0.9)
                            .opacity(routine.isReminderOn ? 1 : 0)
                        
                        Spacer()
                        
                        let count = routine.weekDays ?? []
                        
                        
                        Text(count.count == 7 ? "Everyday" : "\(count.count) times a week")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 10)
                    
                    let calendar = Calendar.current
                    let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
                    let symbols = calendar.weekdaySymbols
                    let startData = currentWeek?.start ?? Date()
                    let activeWeekDays = routine.weekDays ?? []
                    let activePlot = symbols.indices.map { index -> (String, Date) in
                        let currentDate = calendar.date(byAdding: .day, value: index, to: startData)
                        return(symbols[index], currentDate ?? Date())
                    }
                    
                    HStack {
                        ForEach(activePlot.indices, id: \.self) { index in
                            let item = activePlot[index]
                            VStack(spacing: 6) {
                                Text(item.0.prefix(3))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                let status = activeWeekDays.contains { $0 == item.0}
                                
                                
                                Text(getDate(date: item.1))
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .padding(8)
                                    .background(
                                        Circle()
                                            .fill(Color(routine.color ?? "Card-1"))
                                            .opacity(status ? 1 : 0)
                                    
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        
                    }
                    .padding(.top, 15)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color("C1"))
                        
                )
                .onTapGesture {
                    vm.editRoutine = routine
                    vm.restoreEditData()
                    vm.addNewRoutine.toggle()
                }
            }
        }
        .preferredColorScheme(.dark)
        

    }
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
        
        
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .environmentObject(RoutineViewModel())
    }
}
