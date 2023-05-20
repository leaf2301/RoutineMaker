//
//  TimePicker.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 19/05/2023.
//

import SwiftUI

struct TimePicker: View {
    @EnvironmentObject var vm : RoutineViewModel
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    vm.isShowingTime.toggle()
                }
            DatePicker("", selection: $vm.reminderDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("C1"))
                )
                .padding()
                .overlay(
                    Button {
                        vm.isShowingTime.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    ,alignment: .topTrailing
                )
                .padding()
                
        }
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker()
            .environmentObject(RoutineViewModel())
            .preferredColorScheme(.dark)
    }
}
