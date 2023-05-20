//
//  FrequencyAndDayCheck.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import SwiftUI

struct FrequencyAndDayCheck: View {
    @EnvironmentObject var vm: RoutineViewModel
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Frequecy")
                    .font(.callout.bold())
                let weekDays = Calendar.current.weekdaySymbols
                    
                HStack(spacing: 10) {
                    ForEach(weekDays, id: \.self) { day in
                        let index = vm.weekDays.firstIndex { $0 == day } ?? -1
                        Text(day.prefix(2))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(index != -1 ? Color(vm.dayColor) : Color("C1"))
                            }
                            .onTapGesture {
                                withAnimation {
                                    if index == -1 {
                                        vm.weekDays.append(day)
                                    } else {
                                        vm.weekDays.remove(at: index)
                                    }
                                }
                            }
                    }
                }
                .padding(.top, 15)
            }

        }

    }
}

struct FrequencyAndDayCheck_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyAndDayCheck()
            .environmentObject(RoutineViewModel())
    }
}
