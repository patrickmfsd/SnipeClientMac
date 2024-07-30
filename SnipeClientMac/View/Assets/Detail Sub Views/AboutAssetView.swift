//
//  AboutAssetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 3/6/2024.
//

import SwiftUI

struct AboutAssetView: View {
    @StateObject private var service = SnipeAPIService()
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @State private var showCreatedDate: Bool = false
    
    var hardwareID: Int32
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    GroupBox {
                        if let serial = service.hardwareDetailItem?.serial {
                            DetailRow(title: "Serial", value: "\(serial)")
                        }
                        if let assetTag = service.hardwareDetailItem?.assetTag {
                            DetailRow(title: "Asset Tag", value: "\(assetTag)")
                        }
                    }
                    GroupBox("Notes") {
                        HStack {
                            Text(service.hardwareDetailItem?.notes ?? "No Asset Notes.")
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                    loanStatusGroupBox()
                    detailsGroupBox()
                    supplierGroupBox()
                }
                .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
            }
            .padding(.horizontal)
            .onAppear {
                service.fetchSpecificHardware(id: hardwareID)
            }
            .refreshable {
                service.fetchSpecificHardware(id: hardwareID)
            }
        }
        .navigationTitle("About")
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
            if let lastCheckout = service.hardwareDetailItem?.lastCheckout?.formatted {
                DetailRow(title: "Last Checkout", value: lastCheckout)
            }
            if let expectedCheckin = service.hardwareDetailItem?.expectedCheckin?.formatted {
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
        if let eol = service.hardwareDetailItem?.eol, let assetEolDate = service.hardwareDetailItem?.assetEolDate?.formatted {
            return DetailRow(title: "EOL", value: "\(eol) (\(assetEolDate))").eraseToAnyView()
        }
        return EmptyView().eraseToAnyView()
    }
    
    private func auditDetailRows() -> some View {
        Group {
            if let lastAuditDate = service.hardwareDetailItem?.lastAuditDate?.formatted {
                DetailRow(title: "Last Audit", value: lastAuditDate)
            }
            if let nextAuditDate = service.hardwareDetailItem?.nextAuditDate?.formatted {
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
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 15, material: .thin))
    }
}

//#Preview {
//    AssetDetailView(hardwareID: 0)
//}
