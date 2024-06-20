//
//  DashboardView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var service = SnipeAPIService()
    
    let columns = [
        GridItem(.adaptive(minimum: 300, maximum: 520)),
        GridItem(.adaptive(minimum: 300, maximum: 520)),
    ]
    
    var body: some View {
        ScrollView {
            #if os(iOS)
            VStack(spacing: 10) {
                AssetWidget()
                UsersWidgetView()
            }
            .padding(.horizontal)
            #else
            LazyVGrid(columns: columns) {
                AssetWidget()
                UsersWidgetView()
            }
            .padding()
            #endif
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    service.fetchHardware()
                    service.fetchUsers()
                }, label: {
                    Label("Refresh", systemImage: "arrow.clockwise")
                })
            }
        }
    }
}

#Preview {
    DashboardView()
}
