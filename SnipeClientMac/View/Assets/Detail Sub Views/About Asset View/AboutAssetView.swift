//
//  AboutAssetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 8/19/24.
//

import SwiftUI

struct AboutAssetView: View {
    
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32

    
    var body: some View {
        VStack(spacing: 15) {
            GroupBox(label: Text("Details")) {
                VStack {
                    if let assetTag = service.hardwareDetailItem?.assetTag {
                        DetailRow(title: "Asset Tag", value: "\(assetTag)")
                    }
                    if let serial = service.hardwareDetailItem?.serial {
                        Divider()
                        DetailRow(title: "Serial", value: "\(serial)")
                    }
                    if let warrantyTime = service.hardwareDetailItem?.warrantyMonths,
                       let warrantyExpires = service.hardwareDetailItem?.warrantyExpires?.formatted {
                        Divider()
                        DetailRow(title: "Warrenty", value: "\(warrantyTime) (\(warrantyExpires))")
                    }
                    if let eol = service.hardwareDetailItem?.eol, let assetEolDate = service.hardwareDetailItem?.assetEolDate?.formatted {
                        Divider()
                        DetailRow(title: "EOL", value: "\(eol) (\(assetEolDate))")
                    }
                    if let lastAuditDate = service.hardwareDetailItem?.lastAuditDate?.formatted {
                        Divider()
                        DetailRow(title: "Last Audit", value: lastAuditDate)
                    }
                    if let nextAuditDate = service.hardwareDetailItem?.nextAuditDate?.formatted {
                        Divider()
                        DetailRow(title: "Last Audit", value: nextAuditDate)
                    }
                    if let bookValue = service.hardwareDetailItem?.bookValue {
                        Divider()
                        DetailRow(title: "Book Value", value: bookValue)
                    }
                }
            }
//            GroupBox(label: Text("Notes")) {
//                HStack {
//                    Text(service.hardwareDetailItem?.notes ?? "No Asset Notes.")
//                        .multilineTextAlignment(.leading)
//                    Spacer()
//                }
//            }
//            GroupBox(label: Text("Loan Status")) {
//                if let assignedTo = service.hardwareDetailItem?.assignedTo?.name {
//                    HStack {
//                        Image(systemName: "person.circle.fill")
//                            .symbolRenderingMode(.hierarchical)
//                            .font(.largeTitle)
//                        VStack(alignment: .leading) {
//                            Text("Assigned To")
//                                .font(.footnote)
//                                .foregroundStyle(.secondary)
//                            Text(assignedTo)
//                                .font(.title2)
//                                .fontWeight(.medium)
//                        }
//                        Spacer()
//                    }
//                } else {
//                    HStack {
//                        Image(systemName: "questionmark.circle")
//                            .symbolRenderingMode(.hierarchical)
//                            .font(.largeTitle)
//                        VStack(alignment: .leading) {
//                            Text("Unassigned")
//                                .font(.title2)
//                                .fontWeight(.medium)
//                        }
//                        Spacer()
//                    }
//                }
//            }
//            if service.hardwareDetailItem?.location?.name != nil || service.hardwareDetailItem?.rtdLocation?.name != nil || service.hardwareDetailItem?.lastCheckout != nil {
//                GroupBox(label: Text("Loan Details")) {
//                    VStack {
//                        if let location = service.hardwareDetailItem?.location?.name {
//                            DetailRow(title: "Location", value: location)
//                        }
//                        if let defaultLocation = service.hardwareDetailItem?.rtdLocation?.name {
//                            Divider()
//                            DetailRow(title: "Default Location", value: defaultLocation)
//                        }
//                        if let lastCheckout = service.hardwareDetailItem?.lastCheckout?.formatted {
//                            Divider()
//                            DetailRow(title: "Last Checkout", value: lastCheckout)
//                        }
//                        if let expectedCheckin = service.hardwareDetailItem?.expectedCheckin?.formatted {
//                            Divider()
//                            DetailRow(title: "Expected Check-In", value: expectedCheckin)
//                        }
//                    }
//                }
//            }
            GroupBox {
                HStack {
                    Spacer()
                    VStack {
                        Text("Checked In")
                            .foregroundStyle(.secondary)
                        Text("\(service.hardwareDetailItem?.checkinCounter ?? 0)")
                            .font(.title2)
                    }
                    Divider()
                    VStack {
                        Text("Checked Out")
                            .foregroundStyle(.secondary)
                        Text("\(service.hardwareDetailItem?.checkoutCounter ?? 0)")
                            .font(.title2)
                    }
                    Divider()
                    VStack {
                        Text("Requested")
                            .foregroundStyle(.secondary)
                        Text("\(service.hardwareDetailItem?.requestsCounter ?? 0)")
                            .font(.title2)
                    }
                    Spacer()
                }
                .frame(height: 50)
            }

            GroupBox {
                VStack {
                    if let updated = service.hardwareDetailItem?.updatedAt?.formatted {
                        DetailRow(title: "Updated", value: updated)
                    }
                    if let created = service.hardwareDetailItem?.createdAt?.formatted, let age = service.hardwareDetailItem?.age {
                        Divider()
                        DetailRow(title: "Created", value: "\(created) (\(age))")
                    }
                }
            }
            Spacer()
        }
        .groupBoxStyle(
            MaterialGroupBox(
                spacing: 10,
                radius: 8,
                background: .color(.secondary.opacity(0.3))
            )
        )
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
        .refreshable {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

