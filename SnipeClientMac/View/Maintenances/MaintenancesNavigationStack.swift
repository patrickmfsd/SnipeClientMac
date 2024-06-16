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
            MaintenancesListView()
        }
        .navigationTitle("All Users")
    }
}

#Preview {
    MaintenancesNavigationStack()
}
