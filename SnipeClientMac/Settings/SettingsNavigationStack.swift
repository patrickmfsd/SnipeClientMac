//
//  SettingsNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import SwiftUI

struct SettingsNavigationStack: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {
        Group {
            if prefersTabNavigation {
                SettingsView()
            } else {
                NavigationStack {
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    SettingsNavigationStack()
}
