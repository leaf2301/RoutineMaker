//
//  ReminderAndNoti.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import SwiftUI

struct ReminderAndNoti: View {
    @EnvironmentObject var vm: RoutineViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Reminder")
                        .fontWeight(.semibold)
                    Text("Just Notification")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Toggle("", isOn: $vm.isReminderOn)
                    .labelsHidden()
            }
            
            HStack(spacing: 12) {
                Label(vm.reminderDate.formatted(date: .omitted, time: .shortened), systemImage: "clock")
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color("C1"), in:
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
                    .onTapGesture {
                        withAnimation {
                            vm.isShowingTime.toggle()
                        }
                    }
                
                Spacer()
                
                TextField("Reminder Text", text: $vm.reminderText)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color("C1"), in:
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
            }
            .frame(height: vm.isReminderOn ? nil : 10)
            .opacity(vm.isReminderOn ? 1 : 0)
        
        }
    }
}

struct ReminderAndNoti_Previews: PreviewProvider {
    static var previews: some View {
        ReminderAndNoti()
            .environmentObject(RoutineViewModel())
            .preferredColorScheme(.dark)
    }
}
