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
                GroupBox {
                    HStack(alignment: .center) {
                        Text("Recent Assets")
                            .font(.title2)
                            .fontWeight(.medium)
                        Spacer()
                        VStack(alignment: .center) {
                            Text("\(service.hardwareTotal)")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            Text("Total Assets")
                                .font(.footnote)
                        }
                    }
                }
                .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 20, material: .thick))
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
                        HStack {
                            AsyncImage(url: URL(string: hardware.image ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80)
                            } placeholder: {
                                Image(systemName: "laptopcomputer")
                                    .font(.system(size: 50))
                            }
                            VStack(alignment: .leading) {
                                Text("\(hardware.name ?? hardware.assetTag)")
                                Text("\(hardware.manufacturer?.name ?? "") - \(hardware.modelNumber ?? "")")
                            }
                            Spacer()
                        }
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                }
            }
            .onAppear {
                service.fetchHardware()
            }
            .alert(item: $service.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .thin))
        .frame(maxWidth: 500)
    }
}

#Preview {
    AssetWidget()
}
