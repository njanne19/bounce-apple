//
//  ContentView.swift
//  Bounce
//
//  Created by Nick on 2/18/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: VPNController
    
    var body: some View {
        Grid {
            GridRow {
                Text("VPN Profile Status: \(controller.vpnProfileIsInstalled == true ? "Installed" : "Not Installed")")
                    .font(.headline)
                    .frame(minWidth: 600, alignment: .leading)
                Button(controller.vpnProfileIsInstalled == true ? "Uninstall" : "Install") {
                    controller.toggleVPNProfileInstallation()
                }
                .frame(minWidth: 100)
            }
            TextEditor(text: /*@START_MENU_TOKEN@*/.constant("Placeholder")/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}

#Preview {
    ContentView(controller: .init())
}
