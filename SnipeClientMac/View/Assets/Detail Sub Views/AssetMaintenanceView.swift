//
//  AssetMaintenanceView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 24/7/2024.
//

import SwiftUI

struct AssetMaintenanceNaviagtionStack: View {
    var hardwareID: Int32
    
    var body: some View {
        NavigationStack {
            AssetMaintenanceView(hardwareID: hardwareID)
                .navigationTitle("Maintenance Jobs")
                #if os(iOS)
                .navigationBarTitleDisplayMode(.large)
                #endif
        }
    }
}


struct AssetMaintenanceView: View {
    @StateObject private var service = SnipeAPIService()
    var hardwareID: Int32
    
    var body: some View {
        #if os(iOS)
        list
        #else
        standard
        #endif
    }
    
    var standard: some View {
        VStack(alignment: .leading) {
            if service.maintenancesItem.isEmpty {
                ContentUnavailableView("No Maintenance Jobs", systemImage: "wrench.and.screwdriver")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .init(horizontal: .center, vertical: .center))
            } else {
                ForEach(service.maintenancesItem) { maintenance in
                    GroupBox {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(maintenance.assetMaintenanceType ?? "")
                                    .font(.subheadline)
                                Text(maintenance.title ?? "")
                                    .font(.headline)
                                Text("Logged By: \(maintenance.userId?.name ?? "")")
                                Divider()
                                if maintenance.completionDate?.formatted.isEmpty == false {
                                    Text("Completion: \(maintenance.completionDate?.formatted ?? "")")
                                } else {
                                    Text("Created: \(maintenance.createdAt?.formatted ?? "")")
                                }
                            }
                            Spacer()
                            Group {
                                if maintenance.completionDate?.formatted.isEmpty == false {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                        .font(.title)
                                } else {
                                    Image(systemName: "wrench.and.screwdriver.fill")
                                        .symbolRenderingMode(.hierarchical)
                                        .foregroundStyle(.orange)
                                        .font(.title2)
                                }
                            }
                        }
                    }
                    .groupBoxStyle(
                        CustomGroupBox(
                            spacing: 10,
                            radius: 8,
                            background: .color(.secondary.opacity(0.3))
                        )
                    )
                }
            }
        }
        .onAppear {
            service.fetchAssetMaintenances(assetID: hardwareID)
        }
        .refreshable {
            service.fetchAssetMaintenances(assetID: hardwareID)
        }
    }
    
    var list: some View {
        VStack(alignment: .leading) {
            if service.maintenancesItem.isEmpty {
                ContentUnavailableView("No Maintenance Jobs", systemImage: "wrench.and.screwdriver")
            } else {
                List {
                    ForEach(service.maintenancesItem) { maintenance in
                        Section {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(maintenance.assetMaintenanceType ?? "")
                                        .font(.subheadline)
                                    Text(maintenance.title ?? "")
                                        .font(.headline)
                                    Text("Logged By: \(maintenance.userId?.name ?? "")")
                                    Divider()
                                    if maintenance.completionDate?.formatted.isEmpty == false {
                                        Text("Completion: \(maintenance.completionDate?.formatted ?? "")")
                                    } else {
                                        Text("Created: \(maintenance.createdAt?.formatted ?? "")")
                                    }
                                }
                                Spacer()
                                Group {
                                    if maintenance.completionDate?.formatted.isEmpty == false {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.green)
                                            .font(.title)
                                    } else {
                                        Image(systemName: "wrench.and.screwdriver.fill")
                                            .symbolRenderingMode(.hierarchical)
                                            .foregroundStyle(.orange)
                                            .font(.title2)
                                    }
                                }
                            }
                        }
                    }
                }
                #if os(iOS)
                .listStyle(.insetGrouped)
                #endif
            }
        }
        .onAppear {
            service.fetchAssetMaintenances(assetID: hardwareID)
        }
        .refreshable {
            service.fetchAssetMaintenances(assetID: hardwareID)
        }
    }
}

//#Preview {
//    AssetMaintenanceView()
//}
