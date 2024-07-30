//
//  AssetDetailView.swift
//  SnipeClientMac
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
        .padding(.horizontal)
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
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
                Button(action: {
                        // Action
                }, label: {
                    Label("Add", systemImage: "plus")
                })
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
        VStack(spacing: 10) {
            Header(hardwareID: hardwareID)
            NavigationLink(
                destination: AboutAssetView(hardwareID: hardwareID)
            ) {
                GroupBox {
                    HStack {
                        Label("About", systemImage: "info.circle.fill")
                            .imageScale(.large)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.vertical, 5)
                }
            }
            Cards()
            AssignedTo(hardwareID: hardwareID)
            Spacer()
        }
        .padding(.horizontal)
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
    }
    
    var standard: some View {
        HStack {
            VStack(spacing: 10) {
                Header(hardwareID: hardwareID)
                Cards()
                Spacer()
            }
            AboutAssetView(hardwareID: hardwareID)
        }
        .padding()
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
    }
}

struct Header: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        Group {
                VStack(alignment: .center) {
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
               let deviceName = service.hardwareDetailItem?.name {
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
                    .foregroundColor(.secondary)
                    if deviceName != "" {
                        Text("\(deviceName)")
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
                    .background(.green, in: Capsule())
            }
            if service.hardwareDetailItem?.byod == true {
                Text("BYOD")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.green, in: Capsule())
            }
            if let warrantyTime = service.hardwareDetailItem?.warrantyMonths,
               let warrantyExpires = service.hardwareDetailItem?.warrantyExpires?.formatted {
                Text("\(warrantyTime) (\(warrantyExpires))")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.green, in: Capsule())
            }
        }
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

struct Cards: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                FeaturedNavigation(symbol: "laptopcomputer.and.iphone", color: .blue, label: "Maintenances")
                FeaturedNavigation(symbol: "cube.box", color: .blue, label: "Accessories")
            }
            HStack {
                FeaturedNavigation(symbol: "cpu", color: .green, label: "Components")
                FeaturedNavigation(symbol: "drop.halffull", color: .orange, label: "Consumables")
            }
        }
    }
}

struct AssignedTo: View {
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        VStack {
            if let assignedTo = service.hardwareDetailItem?.assignedTo?.name {
                GroupBox("Assigned To") {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(assignedTo)
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                        Spacer()
                    }
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

