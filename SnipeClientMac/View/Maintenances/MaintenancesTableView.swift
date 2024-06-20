//
//  MaintenancesTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 20/6/2024.
//

import SwiftUI

struct MaintenancesTableView: View {
    @StateObject private var viewModel = SnipeAPIService()
    
    @SceneStorage("MaintenancesTableConfig")
    private var columnCustomization: TableColumnCustomization<MaintenanceItem>
    
    @State private var selection: MaintenanceItem.ID?
    
    var body: some View {
        VStack {
            if let error = viewModel.errorMessage {
                Text("Error: \(error.message)")
                    .foregroundColor(.red)
            } else {
                Table(viewModel.maintenancesItem, selection: $selection, columnCustomization: $columnCustomization) {
                    TableColumn("Title") { maintenance in
                        Text("\(maintenance.title)")
                    }
                    .customizationID("title")
                    TableColumn("Type") { maintenance in
                        Text("\(maintenance.assetMaintenanceType)")
                    }
                    .customizationID("assetMaintenanceType")
                    TableColumn("Created") { maintenance in
                        Text("\(maintenance.createdAt)")
                    }
                    .customizationID("createdAt")
                    TableColumn("Started") { maintenance in
                        Text("\(maintenance.startDate)")
                    }
                    .customizationID("startDate")
                    TableColumn("Completed") { maintenance in
                        Text("\(maintenance.completionDate)")
                    }
                    .customizationID("completionDate")
                    TableColumn("Supplier") { maintenance in
                        Text("\(maintenance.supplier?.name ?? "")")
                    }
                    .customizationID("supplier")
                    TableColumn("Cost") { maintenance in
                        Text("\(maintenance.cost ?? 0.00)")
                    }
                    .customizationID("cost")
                }
            }
        }
        .onAppear {
            viewModel.fetchAllMaintenances()
        }
        .refreshable {
            viewModel.fetchAllMaintenances()
        }
        .alert(item: $viewModel.errorMessage) { error in
            Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    MaintenancesTableView()
}
