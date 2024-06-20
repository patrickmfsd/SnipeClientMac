//
//  AssetWidgetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetWidget: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Recent Assets")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("\(service.hardwareTotal) Assets")
                        .foregroundStyle(.secondary)
                }.padding(10)
                if service.hardwareItems.isEmpty {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 10) {
                            Image(systemName: "tv.slash")
                                .font(.largeTitle)
                            Text("Assets Unavailable")
                                .font(.title2)
                        }
                        Spacer()
                    }
                    .padding()
                } else {
                    ForEach(service.hardwareItems.prefix(5)) { hardware in
                        Divider()
                        HStack(spacing: 10) {
                            AsyncImage(url: URL(string: hardware.image ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80)
                            } placeholder: {
                                Image(systemName: "laptopcomputer")
                                    .font(.system(size: 60))
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                if let manufacturerName = hardware.manufacturer?.name,
                                   let modelName = hardware.model?.name,
                                   let deviceName = hardware.name {
                                    VStack(alignment: .leading, spacing: 5) {
                                        if manufacturerName != "" {
                                            Text("\(manufacturerName)")
                                                .font(.footnote)
                                        }
                                        
                                        if modelName != "" && modelName != deviceName {
                                            Text("\(modelName)")
                                                .font(modelName != "" ? .body : .footnote)
                                        }
                                        
                                        if deviceName != "" {
                                            Text("\(deviceName)")
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            .onAppear {
                service.fetchHardware()
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .thin))
        .frame(minWidth: 320, maxWidth: 500)
    }
}

#Preview {
    AssetWidget()
}
