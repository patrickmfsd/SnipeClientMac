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
            if service.maintenancesItem.isEmpty {
                ContentUnavailableView(
                    "Maintenances Jobs Unavailable",
                    systemImage: "screwdriver"
                )
                .frame(minHeight: 450)
            } else {
                ForEach(service.maintenancesItem.prefix(8)) { maintenance in
                    NavigationLink(destination: EmptyView()) {
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
                                .tint(.secondary)
                                if let assetName = maintenance.asset?.name {
                                    Text(assetName)
                                        .multilineTextAlignment(.leading)
                                }
                                Text(maintenance.title ?? "")
                                    .lineLimit(3, reservesSpace: true)
                                    .multilineTextAlignment(.leading)
                                    .font(.headline)
                            }
                            .padding(.top)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .tint(.accentColor)
                                .font(.system(size: 16))
                        }
                        .frame(height: 80)
                    }
                    .buttonBorderShape(.roundedRectangle)
                }
            }
        }
        .onAppear {
            service.fetchAllMaintenances()
        }
    }
}

#Preview {
    MaintenanceWidgetView()
}
