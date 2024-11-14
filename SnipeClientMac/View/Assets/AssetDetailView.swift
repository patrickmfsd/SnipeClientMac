//
//  AssetDetailView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 7/30/24.
//

import SwiftUI

struct AssetDetailView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation

    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        VStack(spacing: 10) {
            if prefersTabNavigation {
                compact
            } else {
                standard
            }
        }
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .automatic) {
                Menu {
                    Button(action: {
                            // Action
                    }, label: {
                        Label("New Maintenance Job", systemImage: "screwdriver")
                    })
                    Divider()
                    Button(action: {
                            // Action
                    }, label: {
                        Label("Show History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    })
                    Button(action: {
                            // Action
                    }, label: {
                        Label("Edit", systemImage: "pencil")
                    })
                    Button(action: {
                            // Action
                    }, label: {
                        Label("Delete", systemImage: "trash")
                    })
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
            }
            #else
            ToolbarItem(placement: .automatic) {
                HStack(spacing: 10) {
                    Button(action: {
                            // Action
                    }) {
                        Label("Log Repair", systemImage: "wrench.and.screwdriver.fill")
                    }
                    .labelStyle(.titleAndIcon)
                    
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: {
                        // Action
                }) {
                    Label("Check In", systemImage: "square.and.arrow.down.fill")
                }
                .labelStyle(.titleAndIcon)
            }
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                        // Action
                }, label: {
                    Text("Edit")
                })
            }
            #endif
        }
    }
    
    var compact: some View {
        ScrollView(.vertical){
            VStack(spacing: 10) {
                CompactHeader(hardwareID: hardwareID)
                NavigationLink(
                    destination: AboutAssetNavigationStack(hardwareID: hardwareID)
                ) {
                    GroupBox {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .imageScale(.large)
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.teal)
                            Text("About")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tint)
                        }
                    }
                }
                .foregroundStyle(.primary)
                GroupBox(label: Text("Notes")) {
                    HStack {
                        Text(service.hardwareDetailItem?.notes ?? "No Asset Notes.")
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                AssignedTo(hardwareID: hardwareID)
                MaintenancesCard(hardwareID: hardwareID)
                Spacer()
            }
            .groupBoxStyle(
                CustomGroupBox(
                    spacing: 10,
                    radius: 8,
                    background: .color(.secondary.opacity(0.3))
                )
            )
            .padding(.horizontal)
        }
    }
    
    var standard: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 20) {
                LargeHeader(hardwareID: hardwareID)
                AboutAssetView(hardwareID: hardwareID)
            }
            .frame(width: 400)
            GroupBox {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Maintenance Jobs")
                        .font(.title2)
                        .fontWeight(.medium)
                    AssetMaintenanceView(hardwareID: hardwareID)
                    Spacer()
                }
            }
            .groupBoxStyle(
                CustomGroupBox(
                    spacing: 8,
                    radius: 8,
                    background: .color(.secondary.opacity(0.1))
                )
            )
        }
        .padding(10)
    }
}

struct CompactHeader: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 15) {
                image
                text
            }
        }
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
    
    var image: some View {
        AsyncImage(url: URL(string: service.hardwareDetailItem?.image ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                #if os(iOS)
                .frame(minWidth: 80, maxWidth: 200, minHeight: 80, maxHeight: 200)
                #elseif os(macOS)
                .frame(minWidth: 250, maxWidth: 350, minHeight: 250, maxHeight: 350)
                #endif
                .padding(15)
                .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        } placeholder: {
            Image(systemName: "laptopcomputer")
                .frame(minWidth: 80, maxWidth: 200)
        }
    }
    
    var text: some View {
        VStack(spacing: 10) {
            if let manufacturerName = service.hardwareDetailItem?.manufacturer?.name,
               let modelName = service.hardwareDetailItem?.model?.name,
               let deviceName = service.hardwareDetailItem?.name,
               let assetTag = service.hardwareDetailItem?.assetTag {
                VStack(alignment: .center, spacing: 5) {
                    HStack(alignment: .center, spacing: 5) {
                        if manufacturerName != "" {
                            Text("\(manufacturerName)")
                                .font(.title3)
                        }
                        
                        if modelName != "" && modelName != deviceName {
                            Text("\(modelName)")
                                .font(.title3)
                        }
                    }
                    .foregroundStyle(.secondary)
                    if deviceName != "" {
                        Text("\(deviceName)")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .fontWeight(.semibold)
                    } else if assetTag != "" {
                        Text("\(assetTag)")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .fontWeight(.semibold)
                    }
                }
            }
            DeviceTags(hardwareID: hardwareID)
        }
    }
}

struct LargeHeader: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            image
            text
        }
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
    
    var image: some View {
        AsyncImage(url: URL(string: service.hardwareDetailItem?.image ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 155)
                .padding(15)
                .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        } placeholder: {
            Image(systemName: "laptopcomputer")
                .frame(minWidth: 80, maxWidth: 200)
        }
    }
    
    var text: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let manufacturerName = service.hardwareDetailItem?.manufacturer?.name,
               let modelName = service.hardwareDetailItem?.model?.name,
               let deviceName = service.hardwareDetailItem?.name,
               let assetTag = service.hardwareDetailItem?.assetTag {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 5) {
                        if manufacturerName != "" {
                            Text("\(manufacturerName)")
                                .font(.title3)
                        }
                        
                        if modelName != "" && modelName != deviceName {
                            Text("\(modelName)")
                                .font(.title3)
                        }
                    }
                    .foregroundStyle(.secondary)
                    if deviceName != "" {
                        Text("\(deviceName)")
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                    } else if assetTag != "" {
                        Text("\(assetTag)")
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                    }
                }
            }
            DeviceTags(hardwareID: hardwareID)
        }
    }
}

struct DeviceTags: View {
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        HStack(spacing: 5) {
            Text("\(String(describing: service.hardwareDetailItem?.statusLabel?.statusMeta?.capitalized ?? "Unknown"))")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(8)
                .background("\(String(describing: service.hardwareDetailItem?.statusLabel?.statusMeta?.capitalized ?? "Unknown"))" == "deployed" ? .gray : .green, in: Capsule())
            
            if service.hardwareDetailItem?.requestable == true {
                Text(service.hardwareDetailItem?.statusLabel?.name ?? "")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.teal, in: Capsule())
            }
            if service.hardwareDetailItem?.byod == true {
                Text("BYOD")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.purple, in: Capsule())
            }
        }
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

struct MaintenancesCard: View {
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        VStack {
            HStack {
                Text("Maintenances")
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                NavigationLink(destination: AssetMaintenanceNaviagtionStack(hardwareID: hardwareID)) {
                    Text("View All")
                }
            }
            if service.maintenancesItem.isEmpty {
                GroupBox {
                    ContentUnavailableView("No Maintenance Jobs", systemImage: "wrench.and.screwdriver")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .init(horizontal: .center, vertical: .center))
                }
            } else {
                ForEach(service.maintenancesItem.prefix(3)) { maintenance in
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
    }
}

struct AssignedTo: View {
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        GroupBox(label: Text("Loan")) {
            if let assignedTo = service.hardwareDetailItem?.assignedTo?.name {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text("Assigned To")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Text(assignedTo)
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }
            } else {
                HStack {
                    Image(systemName: "questionmark.circle")
                        .symbolRenderingMode(.hierarchical)
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text("Unassigned")
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
        .refreshable {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

