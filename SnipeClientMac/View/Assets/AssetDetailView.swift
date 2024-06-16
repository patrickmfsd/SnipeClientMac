//
//  AssetDetailView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 3/6/2024.
//

import SwiftUI

enum views: String, CaseIterable {
    case details = "Details"
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
                case views.details:
                    AboutAssetView(hardwareID: hardwareID)
                case views.maintenance:
                    MaintenanceList(hardwareID: hardwareID)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Select View", selection: $selectedSegment) {
                    ForEach(views.allCases, id: \.self) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
            ToolbarItem(placement: .primaryAction) {
                Spacer()
            }
            ToolbarItem(placement: .primaryAction) {
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
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: service.hardwareDetailItem?.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            } placeholder: {
                Image(systemName: "laptopcomputer")
                    .font(.system(size: 200))
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
                        Text("Serial: \(serial)")
                            .foregroundStyle(.secondary)
                    }
                    if let assetTag = service.hardwareDetailItem?.assetTag {
                        Text("Asset Tag: \(assetTag)")
                            .foregroundStyle(.secondary)
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



struct AboutAssetView: View {
    @StateObject private var service = SnipeAPIService()
    var hardwareID: Int32

    var body: some View {
        List {
            Section {
                DetailRow(title: "EOL", value: "\(String(describing: service.hardwareDetailItem?.eol ?? "Unknown")) Months (\(String(describing: service.hardwareDetailItem?.assetEolDate?.date ?? "")))")
                DetailRow(title: "Book Value", value: "\(String(describing: service.hardwareDetailItem?.bookValue ?? "Unknown"))")
                DetailRow(title: "Notes", value: "\(String(describing: service.hardwareDetailItem?.notes ?? "Unknown"))")
            }
            Section("Supplier") {
                DetailRow(title: "Supplier", value: "\(String(describing: service.hardwareDetailItem?.supplier?.name ?? "Unknown"))")
                DetailRow(title: "Purchase Cost", value: "\(String(describing: service.hardwareDetailItem?.purchaseCost ?? "Unknown"))")
                DetailRow(title: "Order Number", value: "\(String(describing: service.hardwareDetailItem?.orderNumber ?? "Unknown"))")
                DetailRow(title: "Purchase Date", value: "\(String(describing: service.hardwareDetailItem?.purchaseDate?.formatted ?? "Unknown"))")
            }
            Section("Loan Status") {
                DetailRow(title: "Location", value: "\(String(describing: service.hardwareDetailItem?.location?.name ?? "Unknown"))")
                DetailRow(title: "Default Location", value: "\(String(describing: service.hardwareDetailItem?.rtdLocation?.name ?? "Unknown"))")
                DetailRow(title: "Checked Out To", value: "\(String(describing: service.hardwareDetailItem?.assignedTo?.name ?? "Unknown"))")
                DetailRow(title: "Checked Out On", value: "\(String(describing: service.hardwareDetailItem?.lastCheckout ?? "Unknown"))")
                DetailRow(title: "Expected Check-In", value: "\(String(describing: service.hardwareDetailItem?.expectedCheckin ?? "Unknown"))")
                DetailRow(title: "Check-In Counter", value: "\(String(describing: service.hardwareDetailItem?.checkinCounter ?? 0))")
                DetailRow(title: "Check-Out Counter", value: "\(String(describing: service.hardwareDetailItem?.checkoutCounter ?? 0))")
                DetailRow(title: "Requests Counter", value: "\(String(describing: service.hardwareDetailItem?.requestsCounter ?? 0))")
                
            }
            Section {
                DetailRow(title: "Updated", value: "\(String(describing: service.hardwareDetailItem?.updatedAt?.formatted ?? "Unknown"))")
                DetailRow(title: "Created", value: "\(String(describing: service.hardwareDetailItem?.createdAt?.formatted ?? "Unknown"))")
                DetailRow(title: "Age", value: "\(String(describing: service.hardwareDetailItem?.age ?? "Unknown"))")
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
        List(service.maintenances, id: \.asset.id) { maint in
            HStack {
                VStack {
                    Text(maint.asset.title)
                        .onAppear {
                           print(maint.asset.title)
                        }
                }
            }
        }
        .overlay {
            if service.maintenances.isEmpty {
                ContentUnavailableView("No Maintenances", systemImage: "screwdriver", description: Text("No maintenance jobs logged for this asset."))
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
//    AssetDetailView(hardwareID: 0)
//}
