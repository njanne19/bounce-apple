//
//  BounceApp.swift
//  Bounce
//
//  Created by Nick on 2/18/25.
//

import SwiftUI

@main
struct BounceApp: App {
    @StateObject var controller = VPNController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(controller: controller)
        }
    }
}
