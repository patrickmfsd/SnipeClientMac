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
        GroupBox {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Recent Maintenances")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("\(service.maintenancesTotal) Jobs")
                        .foregroundStyle(.secondary)
                }.padding(10)
                if service.maintenancesItem.isEmpty {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 10) {
                            Image(systemName: "screwdriver")
                                .font(.largeTitle)
                            Text("Maintenances Jobs Unavailable")
                                .font(.title2)
                        }
                        Spacer()
                    }
                    .padding()
                } else {
                    ForEach(service.maintenancesItem.prefix(5)) { maintenance in
                        Divider()
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(maintenance.id) \(maintenance.title)")
                                Text(maintenance.assetMaintenanceType)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                service.fetchUsers()
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .thin))
    }
}

#Preview {
    MaintenanceWidgetView()
}
