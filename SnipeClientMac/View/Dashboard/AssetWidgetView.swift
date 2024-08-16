//
//  AssetWidgetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetListWidget: View {
    @StateObject private var service = SnipeAPIService()
    
    #if os(iOS)
    private var imageSize: CGFloat = 120
    private var detailTextAlignment: HorizontalAlignment = .center
    #else
    private var imageSize: CGFloat = 60
    private var detailTextAlignment: HorizontalAlignment = .leading
    #endif
    
    
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
                .frame(minHeight: 450)
            } else {
                #if os(iOS)
                scrollView
                #else
                listView
                #endif
            }
        }
        .onAppear {
            service.fetchHardware()
        }
    }
    
    var scrollView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                ForEach(service.hardwareItems.prefix(10)) { hardware in
                    NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                        VStack(alignment: .center, spacing: 15) {
                            AssetWidgetImage(hardware: hardware, size: imageSize)
                            AssetWidgetDetails(hardware: hardware, alignment: detailTextAlignment)
                        }
                        .frame(height: 200)
                    }
                    .buttonBorderShape(.roundedRectangle)
                }
            }
        }
    }
    
    var listView: some View {
        ForEach(service.hardwareItems.prefix(8)) { hardware in
            NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                HStack(alignment: .center, spacing: 15) {
                    AssetWidgetImage(hardware: hardware, size: imageSize)
                    AssetWidgetDetails(hardware: hardware, alignment: detailTextAlignment)
                    Spacer()
                }
                .frame(height: 80)
            }
            .buttonBorderShape(.roundedRectangle)
        }
    }
}

struct AssetWidgetDetails: View {
    @State var hardware: HardwareItem

    var alignment: HorizontalAlignment
    
    var body: some View {
        Group {
            if let manufacturerName = hardware.manufacturer?.name,
               let modelName = hardware.model?.name,
               let deviceName = hardware.name {
                VStack(alignment: alignment, spacing: 2) {
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
}

struct AssetWidgetImage: View {
    @State var hardware: HardwareItem

    var size: CGFloat
    
    var body: some View {
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
    AssetListWidget()
}
