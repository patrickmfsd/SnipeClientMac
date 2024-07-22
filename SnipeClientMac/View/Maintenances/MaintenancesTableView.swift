//
//  MaintenancesTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 20/6/2024.
//

import SwiftUI

struct MaintenancesTableView: View {
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("MaintenancesTableConfig")
    private var columnCustomization: TableColumnCustomization<Maintenance>
    
    @State private var selection: Maintenance.ID?
    
    var body: some View {
        VStack {
            Table(service.maintenancesItem, selection: $selection, columnCustomization: $columnCustomization) {
                TableColumn("Title") { maintenance in
                    Text("\(maintenance.title ?? "No Title")")
                }
                .customizationID("title")
                TableColumn("Type") { maintenance in
                    Text("\(maintenance.assetMaintenanceType ?? "Unknown Type")")
                }
                .customizationID("assetMaintenanceType")
                TableColumn("Created") { maintenance in
                    Text("\(maintenance.createdAt?.formatted ?? "Unknown")")
                }
                .customizationID("createdAt")
                TableColumn("Technician") { maintenance in
                    Text("\(maintenance.userId?.name ?? "Unknown")")
                }
                .customizationID("createdBy")
                TableColumn("Started") { maintenance in
                    Text("\(maintenance.startDate?.formatted ?? "Unknown")")
                }
                .customizationID("startDate")
                TableColumn("Completed") { maintenance in
                    Text("\(maintenance.completionDate?.formatted ?? "")")
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
        .onAppear {
            service.fetchAllMaintenances()
        }
        .refreshable {
            service.fetchAllMaintenances()
        }
        .onChange(of: service.maintenancesItem) { oldItems, newItems in
            if newItems.last != nil {
                DispatchQueue.main.async {
                    if newItems.count < service.maintenancesTotal {
                        service.fetchAllMaintenances(offset: newItems.count)
                    }
                }
            }
        }
        .alert(item: $service.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Maintenances"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    service.fetchAllMaintenances()
                }),
                secondaryButton: .cancel()
            )
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                if service.isLoading {
                    ProgressView()
                        .scaleEffect(0.6)
                        .progressViewStyle(.circular)
                } else {
                    Button(action: {
                        service.fetchAllMaintenances()
                    }, label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    })
                }
            }
        }
    }
}

#Preview {
    MaintenancesTableView()
}
