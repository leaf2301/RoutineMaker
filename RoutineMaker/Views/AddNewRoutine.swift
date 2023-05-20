//
//  AddNewRoutine.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import SwiftUI

struct AddNewRoutine: View {
    @EnvironmentObject var vm: RoutineViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextFieldAndColorBubble()
                Divider()
                    
                FrequencyAndDayCheck()
                Divider()
                    .padding(10)
                
                ReminderAndNoti()

            }
            .animation(.easeInOut, value: vm.isReminderOn)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .tint(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                        dismiss()
                    } label: {
                        Text("Done")
                            .foregroundColor(vm.doneStatus() ? .white : .gray)
                    }
                    .disabled(!vm.doneStatus())

                }

            }
        }
        .overlay {
            if vm.isShowingTime {
                TimePicker()
            }
        }
    }
}

struct AddNewRoutine_Previews: PreviewProvider {
    static var previews: some View {
        AddNewRoutine()
            .environmentObject(RoutineViewModel())
            .preferredColorScheme(.dark)

    }
}
