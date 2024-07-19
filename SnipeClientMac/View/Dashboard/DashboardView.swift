//
//  DashboardView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation

    @StateObject private var service = SnipeAPIService()
    
    let columns = [
        GridItem(.adaptive(minimum: 300, maximum: 800)),
        GridItem(.adaptive(minimum: 300, maximum: 800)),
    ]
    
    var body: some View {
        ScrollView {
            #if os(iOS)
                if prefersTabNavigation {
                    listView
                } else {
                    gridView
                }
            #else
            gridView
            #endif
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                if service.isLoading {
                    ProgressView()
                        .scaleEffect(0.6)
                        .progressViewStyle(.circular)
                } else {
                    Button(action: {
                        service.fetchHardware()
                        service.fetchUsers()
                        service.fetchAllMaintenances()
                    }, label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    })
                }
            }
        }
    }
    
    var gridView: some View {
        VStack(spacing: 10) {
            StatsWidgetView()
            LazyVGrid(columns: columns) {
                AssetListWidget()
                UsersWidgetView()
                MaintenanceWidgetView()
            }
            Spacer()
        }
        .padding(10)
    }
    
    var listView: some View {
        VStack(spacing: 10) {
            AssetListWidget()
            UsersWidgetView()
            MaintenanceWidgetView()
        }
        .padding(.horizontal)
    }
}

#Preview {
    DashboardView()
}
