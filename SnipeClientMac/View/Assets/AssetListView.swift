//
//  AssetListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetListView: View {
    @StateObject private var viewModel = SnipeAPIService()
    @State private var isShowingInspector = false
    
    @State private var selection: HardwareItem.ID?
    
    @State var id: Int32 = 0

    var body: some View {
        List(viewModel.hardwareItems, selection: $selection) { hardware in
//            NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                AssetRowView(
                    image: hardware.image ?? "",
                    name: hardware.name ?? "",
                    manufacturer: hardware.manufacturer?.name ?? "",
                    model: hardware.model?.name ?? "",
                    assetNumber: hardware.assetTag,
                    serialNumber: hardware.serial ?? ""
                )
                .tag(hardware.id)
                    //            .onTapGesture {
                    //                isShowingInspector.toggle()
                    //
                    //               id = Int32(selection ?? 0)
                    //            }
                    //            .sheet(isPresented: $isShowingInspector) {
                    //                AssetDetailView(hardwareID: id)
                    //            }
//            }
        }
        .onAppear {
            viewModel.fetchHardware()
        }
        .refreshable {
            viewModel.fetchHardware()
        }
    }
}

struct AssetRowView: View {
    var image: String
    var name: String
    var manufacturer: String
    var model: String
    var assetNumber: String
    var serialNumber: String

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            } placeholder: {
                Image(systemName: "laptopcomputer")
                    .font(.system(size: 50))
            }
            VStack(alignment: .leading) {
                if name.isEmpty {
                    Text(assetNumber.isEmpty ? assetNumber : serialNumber)
                        .font(.headline)
                } else {
                    Text(name)
                        .font(.headline)
                }
                Text("\(manufacturer) - \(model)")
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    AssetListView()
}
