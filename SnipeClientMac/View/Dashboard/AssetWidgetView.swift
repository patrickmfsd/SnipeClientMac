//
//  AssetWidgetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetListWidget: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        GroupBox(label:
            Text("Recent Assets")
                .font(.title2)
                .fontWeight(.medium)
        ) {
            if service.hardwareItems.isEmpty {
                ContentUnavailableView(
                    "Assets Unavailable",
                    systemImage: "tv.slash"
                )
                .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(service.hardwareItems.prefix(10)) { hardware in
                        NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                            HStack(alignment: .center, spacing: 15) {
                                AsyncImage(url: URL(string: hardware.image ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "laptopcomputer")
                                        .font(.system(size: 50))
                                }
                                .frame(width: 60, height: 60)
                                .padding(5)
                                .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                                if let manufacturerName = hardware.manufacturer?.name,
                                   let modelName = hardware.model?.name,
                                   let deviceName = hardware.name {
                                        VStack(alignment: .leading, spacing: 2) {
                                            HStack(spacing: 5){
                                                if manufacturerName != "" {
                                                    Text("\(manufacturerName)")
                                                        .foregroundStyle(Color.secondary)
                                                        .fontWeight(.medium)
                                                        .font(.caption)
                                                }
                                                
                                                if modelName != "" && modelName != deviceName {
                                                    Text("\(modelName)")
                                                        .font(.caption)
                                                        .foregroundStyle(Color.secondary)
                                                        .lineLimit(1)
                                                } else {
                                                    Text("")
                                                }
                                            }
                                            if deviceName != "" {
                                                Text("\(deviceName)")
                                                    .fontWeight(.semibold)
                                                    .multilineTextAlignment(.leading)
                                            } else {
                                                Text("\(modelName)")
                                                    .fontWeight(.semibold)
                                                    .multilineTextAlignment(.leading)
                                            }
                                        }
                                        .foregroundColor(.primary)
                                }
                                Spacer()
                            }
                            .padding(10)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .frame(height: 600)
        .onAppear {
            service.fetchHardware()
        }
    }
}

#Preview {
    AssetListWidget()
}
