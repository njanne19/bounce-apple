//
//  ContentView.swift
//  Bounce
//
//  Created by Nick on 2/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Grid {
            GridRow {
                Text("VPN Status: Not Connected")
                    .font(.headline)
                    .frame(minWidth: 600, alignment: .leading)
                Button("Connect") {
                    
                }
                .frame(minWidth: 100)
            }
            TextEditor(text: /*@START_MENU_TOKEN@*/.constant("Placeholder")/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
