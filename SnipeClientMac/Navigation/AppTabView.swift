//
//  AppTabView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 17/7/20.
//  Copyright © 2020 Patrick Mifsud. All rights reserved.
//

import SwiftUI
import SwiftData

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            DashboardNavigationStack()
                .tabItem {
                    Label("Dashboard", systemImage: "gauge.with.dots.needle.67percent")
                }
                .tag("dashboard")
            AssetNavigationStack()
                .tabItem {
                    Label("Assets", systemImage: "laptopcomputer.and.iphone")
                }
                .tag("assets")
            UsersNavigationStack()
                .tabItem {
                    Label("Users", systemImage: "person.2")
                }
                .tag("users")
            MaintenancesNavigationStack()
                .tabItem {
                    Label("Maintenance", systemImage: "screwdriver")
                }
                .tag("maintenance")
            SettingsNavigationStack()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag("settings")
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.dashboard))
}
