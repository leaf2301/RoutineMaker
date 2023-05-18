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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddNewRoutine_Previews: PreviewProvider {
    static var previews: some View {
        AddNewRoutine()
            .environmentObject(RoutineViewModel())
            .preferredColorScheme(.dark)

    }
}
