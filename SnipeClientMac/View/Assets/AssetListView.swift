//
//  AssetListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetListView: View {
    @StateObject private var service = SnipeAPIService()
    @State private var isShowingInspector = false
    
    @State private var selection: HardwareItem.ID?
    
    @State var id: Int32 = 0
    
    @State var searchTerm: String = ""

    var body: some View {
        List(service.hardwareItems, selection: $selection) { hardware in
            NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                AssetRowView(
                    image: hardware.image ?? "",
                    name: hardware.name ?? "",
                    manufacturer: hardware.manufacturer?.name ?? "",
                    model: hardware.model?.name ?? "",
                    assetNumber: hardware.assetTag,
                    serialNumber: hardware.serial ?? ""
                )
                .tag(hardware.id)
            }
            .onAppear {
                if hardware == service.hardwareItems.last {
                    service.fetchHardware(offset: service.hardwareItems.count)
                }
            }
        }
        .onSubmit(of: .search) {
            service.fetchHardware(searchTerm: searchTerm)
        }
        .onAppear {
            service.fetchHardware()
        }
        .refreshable {
            service.fetchHardware()
        }
        .searchable(text: $searchTerm, prompt: "Search")
    }
}

#Preview {
    AssetListView()
}
