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
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(service.hardwareItems.prefix(10)) { hardware in
                                NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                                    VStack(alignment: .center, spacing: 10) {
                                        AsyncImage(url: URL(string: hardware.image ?? "")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 125, height: 125)
                                                .padding(5)
                                                .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                                        } placeholder: {
                                            Image(systemName: "laptopcomputer")
                                                .font(.system(size: 60))
                                        }
                                        if let manufacturerName = hardware.manufacturer?.name,
                                           let modelName = hardware.model?.name,
                                           let deviceName = hardware.name {
                                            HStack {
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
                                                        }
                                                    }
                                                    if deviceName != "" {
                                                        Text("\(deviceName)")
                                                            .fontWeight(.semibold)
                                                            .truncationMode(.tail)
                                                    } else {
                                                        Text("\(modelName)")
                                                            .fontWeight(.semibold)
                                                            .truncationMode(.tail)
                                                    }
                                                }
                                                Spacer()
                                            }
                                            .foregroundColor(.primary)
                                        }
                                    }
                                    .padding(10)
                                    .frame(width: 150, height: 200)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                service.fetchHardware()
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .thin))
    }
}

#Preview {
    AssetWidget()
}
