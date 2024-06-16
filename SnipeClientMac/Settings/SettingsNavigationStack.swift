//
//  SettingsNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import SwiftUI

struct SettingsNavigationStack: View {
    var body: some View {
        NavigationStack {
            SettingsView()
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsNavigationStack()
}
