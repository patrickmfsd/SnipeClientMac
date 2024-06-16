//
//  MaintenancesListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 14/6/2024.
//

import SwiftUI

struct MaintenancesListView: View {
    @StateObject private var viewModel = SnipeAPIService()

    var body: some View {
        List(viewModel.maintenances) { maint in
            Text(maint.asset.title)
        }
        .onAppear {
            viewModel.fetchAllMaintenances()
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
