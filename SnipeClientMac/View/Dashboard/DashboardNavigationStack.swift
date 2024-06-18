//
//  DashboardNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import SwiftUI

struct DashboardNavigationStack: View {
    var body: some View {
        NavigationStack {
            DashboardView()
                .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardNavigationStack()
}
