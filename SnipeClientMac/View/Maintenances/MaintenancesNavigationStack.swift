//
//  MaintenancesNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 14/6/2024.
//

import SwiftUI

struct MaintenancesNavigationStack: View {
    var body: some View {
        NavigationStack {
            Group {
                #if os(iOS)
                MaintenancesListView()
                #else
                MaintenancesTableView()
                #endif
            }
            .navigationTitle("Maintenances")
        }
    }
}

#Preview {
    MaintenancesNavigationStack()
}
