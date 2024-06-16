//
//  ContentView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: AppScreen? = .dashboard
    
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
}

#Preview {
    ContentView()
}
