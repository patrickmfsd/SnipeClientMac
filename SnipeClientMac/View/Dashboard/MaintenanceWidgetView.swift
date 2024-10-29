//
//  MaintenanceWidgetView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 24/6/2024.
//

import SwiftUI

struct MaintenanceCard: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Maintenance")
                .font(.title2)
                .fontWeight(.medium)
            VStack {
                ForEach(service.maintenancesItem.prefix(5)) { maintenance in
                    NavigationLink(destination: EmptyView()) {
                        GroupBox {
                            MaintenanceRow(maintenance: maintenance)

                        }
                        .groupBoxStyle(
                            CustomGroupBox(
                                spacing: 8,
                                radius: 8,
                                background: .color(.secondary.opacity(0.1))
                            )
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .onAppear {
            service.fetchAllMaintenances()
        }
    }
}

#Preview {
    MaintenanceCard()
}
