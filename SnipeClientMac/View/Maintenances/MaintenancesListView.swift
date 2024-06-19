//
//  MaintenancesListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 14/6/2024.
//

import SwiftUI

struct MaintenancesListView: View {
    @StateObject private var viewModel = SnipeAPIService()
    
    @State private var selection: MaintenanceItem.ID?

    var body: some View {
        List(viewModel.maintenancesItem, selection: $selection) { maintenance in
            Text(maintenance.title)
        }
        .onAppear {
            viewModel.fetchAllMaintenances()
            print(viewModel.maintenancesItem)
        }
        .refreshable {
            viewModel.fetchAllMaintenances()
        }
        .navigationTitle("Maintenances")
    }
}

#Preview {
    MaintenancesListView()
}
