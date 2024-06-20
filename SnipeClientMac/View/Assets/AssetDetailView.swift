//
//  AssetDetailView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 3/6/2024.
//

import SwiftUI

enum views: String, CaseIterable {
    case details = "Details"
    case components = "Components"
    case consumables = "Consumables"
    case maintenance = "Maintenance"
}

struct AssetDetailView: View {
    @StateObject private var service = SnipeAPIService()

    var hardwareID: Int32
    
    @State private var selectedSegment: views = .details

    var body: some View {
        VStack {
            DetailHeader(hardwareID: hardwareID)
            switch selectedSegment {
                case .details:
                    AboutAssetView(hardwareID: hardwareID)
                case .components:
                    EmptyView()
                case .consumables:
                    EmptyView()
                case .maintenance:
                    MaintenanceList(hardwareID: hardwareID)
            }
            Spacer()
        }
        .background(.background)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Select View", selection: $selectedSegment) {
                    ForEach(views.allCases, id: \.self) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(.menu)
                .menuIndicator(.visible)
//                .labelsHidden()
            }
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
                    Label("Create Maintenance Job", systemImage: "screwdriver")
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
        .refreshable {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

struct DetailHeader: View {
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: service.hardwareDetailItem?.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, maxWidth: 200)
            } placeholder: {
                Image(systemName: "laptopcomputer")
                    .frame(minWidth: 100, maxWidth: 200)
            }
            VStack(alignment: .leading, spacing: 10) {
                if let manufacturerName = service.hardwareDetailItem?.manufacturer?.name,
                   let modelName = service.hardwareDetailItem?.model?.name,
                   let deviceName = service.hardwareDetailItem?.name {
                    VStack(alignment: .leading, spacing: 5) {
                        if manufacturerName != "" {
                            Text("\(manufacturerName)")
                                .font(.title3)
                        }
                        
                        if modelName != "" && modelName != deviceName {
                            Text("\(modelName)")
                                .font(.title2)
                        }
                        
                        if deviceName != "" {
                            Text("\(deviceName)")
                                .font(.title)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    if let serial = service.hardwareDetailItem?.serial {
                        HStack(spacing: 5) {
                            Text("Serial:")
                                .foregroundStyle(.secondary)
                            Text(serial)
                                .textSelection(.enabled)
                                .foregroundStyle(.secondary)
                        }
                    }
                    if let assetTag = service.hardwareDetailItem?.assetTag {
                        HStack(spacing: 5) {
                            Text("Asset Tag:")
                                .foregroundStyle(.secondary)
                            Text(assetTag)
                                .textSelection(.enabled)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                HStack(spacing: 5) {
                    Text("\(String(describing: service.hardwareDetailItem?.statusLabel?.statusMeta?.capitalized ?? "Unknown"))")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background("\(String(describing: service.hardwareDetailItem?.statusLabel?.statusMeta?.capitalized ?? "Unknown"))" == "deployed" ? .gray : .green)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    
                    if service.hardwareDetailItem?.requestable == true {
                        Text("Requestable")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.green, in: RoundedRectangle(cornerRadius: 5, style: .continuous))
                    }
                    if service.hardwareDetailItem?.byod == true {
                        Text("BYOD")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.green, in: RoundedRectangle(cornerRadius: 5, style: .continuous))
                    }
                    if let warrantyTime = service.hardwareDetailItem?.warrantyMonths,
                       let warrantyExpires = service.hardwareDetailItem?.warrantyExpires {
                        Text("\(warrantyTime) Months (\(warrantyExpires))")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.green, in: RoundedRectangle(cornerRadius: 5, style: .continuous))
                    }
                }
            }
            Spacer()
            if let qr = service.hardwareDetailItem?.qr {
                AsyncImage(url: URL(string: qr)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                } placeholder: {
                    Image(systemName: "qrcode")
                        .font(.system(size: 50))
                }
            }
            if let barcode = service.hardwareDetailItem?.altBarcode {
                AsyncImage(url: URL(string: barcode)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                } placeholder: {
                    Image(systemName: "barcode")
                        .font(.system(size: 50))
                }
            }
        }
        .padding(10)
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}


// ABout Asset
struct AboutAssetView: View {
    @StateObject private var service = SnipeAPIService()
    var hardwareID: Int32

    var body: some View {
        List {
            Section {
                if let eol = service.hardwareDetailItem?.eol,
                   let assetEolDate = service.hardwareDetailItem?.assetEolDate?.date {
                    DetailRow(title: "EOL", value: "\(eol) (\(assetEolDate))")
                }
                if let bookValue = service.hardwareDetailItem?.bookValue {
                    DetailRow(title: "Book Value", value: bookValue)
                }
                if let notes = service.hardwareDetailItem?.notes {
                    DetailRow(title: "Notes", value: notes)
                }
                if let updated = service.hardwareDetailItem?.updatedAt?.formatted {
                    DetailRow(title: "Updated", value: updated)
                }
                if let created = service.hardwareDetailItem?.createdAt?.formatted,
                   let age = service.hardwareDetailItem?.age {
                    DetailRow(title: "Created", value: "\(age) (\(created))")
                }
            }
            Section("Supplier") {
                if let name = service.hardwareDetailItem?.supplier?.name {
                    DetailRow(title: "Supplier", value: name)
                }
                if let purchaseCost = service.hardwareDetailItem?.purchaseCost {
                    DetailRow(title: "Purchase Cost", value: purchaseCost)
                }
                if let orderNumber = service.hardwareDetailItem?.orderNumber {
                    DetailRow(title: "Order Number", value: orderNumber)
                }
                if let purchaseDate = service.hardwareDetailItem?.purchaseDate?.formatted {
                    DetailRow(title: "Purchase Date", value: purchaseDate)
                }
            }
            Section("Loan Status") {
                if let location = service.hardwareDetailItem?.location?.name {
                    DetailRow(title: "Location", value: location)
                }
                if let defaultLocation = service.hardwareDetailItem?.rtdLocation?.name {
                    DetailRow(title: "Default Location", value: defaultLocation)
                }
                DetailRow(title: "Checked Out To", value: "\(String(describing: service.hardwareDetailItem?.assignedTo?.name ?? "Unknown"))")
                DetailRow(title: "Checked Out On", value: "\(String(describing: service.hardwareDetailItem?.lastCheckout ?? "Unknown"))")
                DetailRow(title: "Expected Check-In", value: "\(String(describing: service.hardwareDetailItem?.expectedCheckin ?? "Unknown"))")
                DetailRow(title: "Check-In Counter", value: "\(String(describing: service.hardwareDetailItem?.checkinCounter ?? 0))")
                DetailRow(title: "Check-Out Counter", value: "\(String(describing: service.hardwareDetailItem?.checkoutCounter ?? 0))")
                DetailRow(title: "Requests Counter", value: "\(String(describing: service.hardwareDetailItem?.requestsCounter ?? 0))")
                
            }
        }
        .listStyle(.inset)
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
        .refreshable {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

struct DetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
    }
}

struct MaintenanceList: View {
    @StateObject private var service = SnipeAPIService()
    var hardwareID: Int32

    var body: some View {
        List(service.maintenancesItem) { maintenance in
            HStack {
                VStack {
                    Text(maintenance.title)
                }
            }
        }
        .overlay {
            if service.maintenancesItem.isEmpty {
                ContentUnavailableView("No Maintenances", systemImage: "screwdriver", description: Text("No maintenance jobs logged for this asset."))
            }
        }
        .onAppear {
            service.fetchAssetMaintenances(assetID: hardwareID)
            print(service.maintenancesItem)
            print(service.maintenancesTotal)

        }
        .refreshable {
            service.fetchAssetMaintenances(assetID: hardwareID)
        }
    }
}


//#Preview {
//    AssetDetailView(hardwareID: 0)
//}
