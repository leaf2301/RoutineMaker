//
//  ContentView.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 18/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
