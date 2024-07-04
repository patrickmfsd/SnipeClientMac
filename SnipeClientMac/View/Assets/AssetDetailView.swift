//
//  AssetDetailView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 3/6/2024.
//

import SwiftUI

enum views: String, CaseIterable {
    case details = "About"
    case assets = "Assets"
    case components = "Components"
    case consumables = "Consumables"
    case maintenance = "Maintenance"
    case history = "History"
}

struct AssetDetailView: View {
    @StateObject private var service = SnipeAPIService()

    var hardwareID: Int32
    
    @State private var selectedSegment: views = .details

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                DetailHeader(hardwareID: hardwareID)
                DeviceTags(hardwareID: hardwareID)
                switch selectedSegment {
                    case .details:
                        AboutAssetView(hardwareID: hardwareID)
                    case .assets:
                        EmptyView()
                    case .components:
                        EmptyView()
                    case .consumables:
                        EmptyView()
                    case .maintenance:
                        MaintenanceList(hardwareID: hardwareID)
                    case .history:
                        EmptyView()
                }
                Spacer()
            }
        }
        .refreshable {
            service.fetchSpecificHardware(id: hardwareID)
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
                #if os(macOS)
                .pickerStyle(.segmented)
                #else
                .pickerStyle(.menu)
                .menuIndicator(.visible)
                #endif
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
                    .frame(minWidth: 80, maxWidth: 120, minHeight: 80, maxHeight: 120)
                    .padding(5)
                    .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            } placeholder: {
                Image(systemName: "laptopcomputer")
                    .frame(minWidth: 80, maxWidth: 200)
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
                            Text(
                                "\(deviceName.replacingOccurrences(of: "&#039;", with: "'"))"
                            )
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
        .padding()
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
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
        .padding(.horizontal)
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

// About Asset
struct AboutAssetView: View {
    @StateObject private var service = SnipeAPIService()
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @State private var showCreatedDate: Bool = false
    
    var hardwareID: Int32
    
    var body: some View {
        VStack {
            GroupBox("Notes") {
                HStack {
                    Text(service.hardwareDetailItem?.notes ?? "No Asset Notes.")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }.groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
            loanStatusGroupBox()
            detailsGroupBox()
            supplierGroupBox()
        }
        .padding(.horizontal)
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
        .refreshable {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
    
    private func loanStatusGroupBox() -> some View {
        GroupBox("Loan Status") {
            VStack {
                if let assignedTo = service.hardwareDetailItem?.assignedTo?.name {
                    GroupBox {
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
                    }
                }
                detailRows()
            }            
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
    }
    
    private func detailRows() -> some View {
        Group {
            if let location = service.hardwareDetailItem?.location?.name {
                DetailRow(title: "Location", value: location)
            }
            if let defaultLocation = service.hardwareDetailItem?.rtdLocation?.name {
                DetailRow(title: "Default Location", value: defaultLocation)
            }
            if let lastCheckout = service.hardwareDetailItem?.lastCheckout {
                DetailRow(title: "Last Checkout", value: lastCheckout)
            }
            if let expectedCheckin = service.hardwareDetailItem?.expectedCheckin {
                DetailRow(title: "Expected Check-In", value: expectedCheckin)
            }
            if let checkinCounter = service.hardwareDetailItem?.checkinCounter {
                DetailRow(title: "Check-In Counter", value: "\(checkinCounter)")
            }
            if let checkoutCounter = service.hardwareDetailItem?.checkoutCounter {
                DetailRow(title: "Check-Out Counter", value: "\(checkoutCounter)")
            }
            if let requestsCounter = service.hardwareDetailItem?.requestsCounter {
                DetailRow(title: "Requests Counter", value: "\(requestsCounter)")
            }
        }
    }
    
    private func detailsGroupBox() -> some View {
        GroupBox("Details") {
            VStack(alignment: .leading) {
                eolDetailRow()
                auditDetailRows()
                bookValueDetailRow()
                updatedDetailRow()
                createdDetailRow()
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
    }
    
    private func supplierGroupBox() -> some View {
        GroupBox("Supplier") {
            VStack {
                if let name = service.hardwareDetailItem?.supplier?.name {
                    DetailRow(title: "Supplier", value: name)
                }
                if let purchaseCost = service.hardwareDetailItem?.purchaseCost {
                    DetailRow(title: "Purchase Cost", value: "$\(purchaseCost)")
                }
                if let orderNumber = service.hardwareDetailItem?.orderNumber {
                    DetailRow(title: "Order Number", value: "#\(orderNumber)")
                }
                if let purchaseDate = service.hardwareDetailItem?.purchaseDate?.formatted {
                    DetailRow(title: "Purchase Date", value: purchaseDate)
                }
            }
            if service.hardwareDetailItem?.supplier?.name == nil  {
                ContentUnavailableView("No Supplier Information", systemImage: "truck.box")
                    .frame(maxWidth: .infinity)
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
    }
    
    private func eolDetailRow() -> some View {
        if let eol = service.hardwareDetailItem?.eol, let assetEolDate = service.hardwareDetailItem?.assetEolDate?.date {
            return DetailRow(title: "EOL", value: "\(eol) (\(assetEolDate))").eraseToAnyView()
        }
        return EmptyView().eraseToAnyView()
    }
    
    private func auditDetailRows() -> some View {
        Group {
            if let lastAuditDate = service.hardwareDetailItem?.lastAuditDate {
                DetailRow(title: "Last Audit", value: lastAuditDate)
            }
            if let nextAuditDate = service.hardwareDetailItem?.nextAuditDate {
                DetailRow(title: "Last Audit", value: nextAuditDate)
            }
        }
    }
    
    private func bookValueDetailRow() -> some View {
        if let bookValue = service.hardwareDetailItem?.bookValue {
            return DetailRow(title: "Book Value", value: bookValue).eraseToAnyView()
        }
        return EmptyView().eraseToAnyView()
    }
    
    private func updatedDetailRow() -> some View {
        if let updated = service.hardwareDetailItem?.updatedAt?.formatted {
            return DetailRow(title: "Updated", value: updated).eraseToAnyView()
        }
        return EmptyView().eraseToAnyView()
    }
    
    private func createdDetailRow() -> some View {
        if let created = service.hardwareDetailItem?.createdAt?.formatted, let age = service.hardwareDetailItem?.age {
            return DetailRow(title: "Created", value: showCreatedDate ? "\(age)" : "\(created)")
                .onTapGesture {
                    showCreatedDate.toggle()
                }
                .eraseToAnyView()
        }
        return EmptyView().eraseToAnyView()
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

struct DetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        GroupBox {
            HStack {
                Text(title)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(value)
            }
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
