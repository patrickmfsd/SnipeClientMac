//
//  AppSidebarList.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 25/6/20.
//

import SwiftUI
import SwiftData

struct AppSidebarList: View {
    @Binding var selection: AppScreen?
    @StateObject private var service = SnipeAPIService()
    
    let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String
    
    var body: some View {
        List(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                NavigationLink(value: screen) {
                    screen.label
                }
            }
            #if os(iOS)
            NavigationLink(destination: SettingsNavigationStack()) {
                Label("Settings", systemImage: "gear")
            }
            #endif
        }
        .navigationTitle("\(appName ?? "")")
        .onAppear {
            service.fetchHardware()
            service.fetchUsers()
        }
    }
}

#Preview {
    NavigationSplitView {
        AppSidebarList(selection: .constant(.dashboard))
    } detail: {
        Text(verbatim: "Check out that sidebar!")
    }
}



