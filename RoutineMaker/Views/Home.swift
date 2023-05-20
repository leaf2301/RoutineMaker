//
//  Home.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import SwiftUI

struct Home: View {
    @FetchRequest(entity: Routine.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Routine.dateAdded, ascending: false)], animation: .easeInOut) var routines: FetchedResults<Routine>
    
    @StateObject var vm: RoutineViewModel = RoutineViewModel()

    var body: some View {
        VStack(spacing: 0) {
        
            Text("Activity List")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            
            ScrollView(routines.isEmpty ? .init() : .vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    CardView()
                        .environmentObject(vm)
                    
                    
                    Button {
                        vm.addNewRoutine.toggle()
                    } label: {
                        Label("Add New", systemImage: "plus.circle")
                            .tint(.white)
                    }
                    .font(.callout.bold())
                    
                    
                }
                .padding(.top, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding()
        .sheet(isPresented: $vm.addNewRoutine) {
            vm.resetData()
        } content: {
            AddNewRoutine()
                .environmentObject(vm)
        }
        
    }
    
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
