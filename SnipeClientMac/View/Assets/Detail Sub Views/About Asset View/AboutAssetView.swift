//
//  AboutAssetView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 8/19/24.
//

import SwiftUI

struct AboutAssetView: View {
    
    @StateObject private var service = SnipeAPIService()
    
    var hardwareID: Int32

    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack (alignment: .leading){
                    Text("Checked In")
                        .foregroundStyle(.secondary)
                    Text("\(service.hardwareDetailItem?.checkinCounter ?? 0)")
                        .font(.title2)
                }
                Spacer()
                VStack (alignment: .leading){
                    Text("Checked Out")
                        .foregroundStyle(.secondary)
                    Text("\(service.hardwareDetailItem?.checkoutCounter ?? 0)")
                        .font(.title2)
                }
                Spacer()
                VStack (alignment: .leading){
                    Text("Requested")
                        .foregroundStyle(.secondary)
                    Text("\(service.hardwareDetailItem?.requestsCounter ?? 0)")
                        .font(.title2)
                }
            }
            .frame(height: 50)
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
        .onAppear {
            service.fetchSpecificHardware(id: hardwareID)
        }
        .refreshable {
            service.fetchSpecificHardware(id: hardwareID)
        }
    }
}

