//
//  MaintenancesListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 14/6/2024.
//

import SwiftUI

struct MaintenancesListView: View {
    @StateObject private var service = SnipeAPIService()
    
    @State private var selection: Maintenance.ID?

    var body: some View {
        List(service.maintenancesItem, selection: $selection) { maintenance in
            HStack {
                VStack(alignment: .leading){
                    HStack(spacing: 2) {
                        if maintenance.isWarranty == 1 {
                            Text("Warranty")
                        }
                        if let type = maintenance.assetMaintenanceType {
                            Text(type)
                        }
                    }
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    if let assetName = maintenance.asset?.name {
                        Text(assetName)
                            .multilineTextAlignment(.leading)
                    }
                    Text(maintenance.title ?? "")
                        .lineLimit(3, reservesSpace: true)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                }
                Spacer()
            }
            .frame(height: 80)
            .onAppear {
                if maintenance == service.maintenancesItem.last {
                    service.fetchAllMaintenances(offset: service.maintenancesItem.count)
                }
            }

        }
        .onAppear {
            service.fetchAllMaintenances()
        }
        .refreshable {
            service.fetchAllMaintenances()
        }
        .navigationTitle("Maintenances")
    }
}

#Preview {
    MaintenancesListView()
}
