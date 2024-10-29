//
//  DashboardNavigationStack.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import SwiftUI

struct DashboardNavigationStack: View {
    @State private var isShowingSheet = false
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {
        NavigationStack {
            DashboardView()
                .navigationTitle("Dashboard")
                .toolbar {
                    #if os(iOS)
                    if prefersTabNavigation {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                isShowingSheet.toggle()
                            }, label: {
                                Image(systemName: "gear")
                            })
                        }
                    }
                    #endif
                }
        }
        .sheet(isPresented: $isShowingSheet) {
            NavigationStack {
                SettingsView()
            }
        }
    }
}

#Preview {
    DashboardNavigationStack()
}
