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

struct FeaturedNavigation: View {
    var symbol: String
    var type: SymbolRenderingMode?
    var color: Color
    var label: String
    var count: Int = 0
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: symbol)
                    .font(.title)
                    .symbolVariant(.fill)
                    .foregroundColor(color)
                    .symbolRenderingMode(type ?? .monochrome)
                Text(label)
                    .font(.body)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            Spacer()
            if count != 0 {
                Text("\(count)")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 70)
    }
}


#Preview {
    NavigationSplitView {
        AppSidebarList(selection: .constant(.dashboard))
    } detail: {
        Text(verbatim: "Check out that sidebar!")
    }
}



