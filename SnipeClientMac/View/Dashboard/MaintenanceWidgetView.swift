//
//  MaintenanceWidgetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 24/6/2024.
//

import SwiftUI

struct MaintenanceWidgetView: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        GroupBox(label:
                    Text("Recent Maintenances")
            .font(.title2)
            .fontWeight(.medium)
        ) {
            if service.hardwareItems.isEmpty {
                ContentUnavailableView(
                    "Maintenances Jobs Unavailable",
                    systemImage: "screwdriver"
                )
                .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(service.maintenancesItem.prefix(10)) { maintenance in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(maintenance.id) \(maintenance.title)")
                                Text(maintenance.assetMaintenanceType)
                            }
                            Spacer()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .frame(height: 600)
        .onAppear {
            service.fetchAllMaintenances()
        }
    }
}

#Preview {
    MaintenanceWidgetView()
}
