//
//  TextFieldAndColorBubble.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import SwiftUI

struct TextFieldAndColorBubble: View {
    @EnvironmentObject var vm: RoutineViewModel
    var body: some View {
        VStack {
            TextField("Title", text: $vm.title)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color("C1"), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                                
            HStack {
                ForEach(1..<8, id: \.self) { number in
                    let color = "Card-\(number)"
                    Circle()
                        .fill(Color(color))
                        .frame(width: 30, height: 30)
                        .overlay(content: {
                            if color == vm.dayColor {
                                Image(systemName: "checkmark")
                                    .font(.caption.bold())
                            }
                        })
                        .onTapGesture {
                            vm.dayColor = color
                        }
                        .frame(maxWidth: .infinity)

                }
            }
            .padding(.vertical)

        }
    }
}

struct TextFieldAndColorBubble_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldAndColorBubble()
            .environmentObject(RoutineViewModel())
            .preferredColorScheme(.dark)
    }
}
