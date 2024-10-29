//
//  AssetWidgetView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetCard: View {
    @StateObject private var service = SnipeAPIService()
    
    let rows = [
        GridItem(.fixed(85)),
        GridItem(.fixed(85)),
        GridItem(.fixed(85))
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Assets")
                .font(.title2)
                .fontWeight(.medium)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 10) {
                    ForEach(service.hardwareItems.prefix(25)) { hardware in
                        NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                            AssetItem(hardware: hardware, size: 60)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, -16)
        }
        .padding(.horizontal)
        .onAppear {
            service.fetchHardware()
        }
    }
}

struct AssetItem: View {
    @State var hardware: HardwareItem
    var size: CGFloat
    
    var body: some View {
        GroupBox {
            HStack(alignment: .center, spacing: 12) {
                image
                details
                Spacer()
            }
            .frame(width: 300, height: 70)
        }
        .groupBoxStyle(
            CustomGroupBox(
                spacing: 8,
                radius: 8,
                background: .color(.secondary.opacity(0.1))
            )
        )
    }

    var details: some View {
        Group {
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
                    } else if hardware.assetTag != "" {
                        Text("\(hardware.assetTag)")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                }
                .foregroundStyle(.primary)
            }
        }
    }
    
    var image: some View {
        AsyncImage(url: URL(string: hardware.image ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "laptopcomputer")
                .font(.system(size: 50))
        }
        .frame(width: size, height: size)
        .padding(5)
        .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

#Preview {
    AssetCard()
}
