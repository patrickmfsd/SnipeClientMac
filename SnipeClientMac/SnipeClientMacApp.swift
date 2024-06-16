//
//  SnipeClientMacApp.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import SwiftUI
import SwiftData

@main
struct SnipeClientMacApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
