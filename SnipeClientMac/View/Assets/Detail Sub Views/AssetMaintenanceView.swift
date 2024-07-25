//
//  AssetMaintenanceView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 24/7/2024.
//

import SwiftUI

struct AssetMaintenanceView: View {
    @StateObject private var service = SnipeAPIService()
    var hardwareID: Int32
    
    let columns = [
        GridItem(.flexible(minimum: 300, maximum: 500))
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            if service.maintenancesItem.isEmpty {
                ContentUnavailableView("No Maintenance Jobs", systemImage: "wrench.and.screwdriver")
            } else {
                LazyVGrid(columns: columns) {
                    ForEach(service.maintenancesItem) { maintenance in
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
                                        .foregroundColor(.orange)
                                        .font(.title2)
                                }
                            }
                        }
                        .padding()
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                    }
                }
                Spacer()
            }
        }
        .padding()
        .onAppear {
            service.fetchAssetMaintenances(assetID: hardwareID)
            print(hardwareID)
            
        }
        .refreshable {
            service.fetchAssetMaintenances(assetID: hardwareID)
        }
    }
}

//#Preview {
//    AssetMaintenanceView()
//}
