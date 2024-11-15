//
//  AssetTableView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetTableView: View {
    @Environment(\.openWindow) private var openWindow
    
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("AssetTableConfig") private var columnCustomization: TableColumnCustomization<HardwareItem>
    

    @State private var selection: HardwareItem.ID?
    @State private var searchTerm: String = ""
    
    @State private var isShowingInspector = false
    
    var body: some View {
        VStack {
            Table(service.hardwareItems, selection: $selection, columnCustomization: $columnCustomization) {
                TableColumn("Image") { hardware in
                    AsyncImage(url: URL(string: hardware.image ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(5)
                    } placeholder: {
                        if hardware.manufacturer?.name != "Apple" {
                            Image(systemName: "pc")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 50))
                        } else {
                            Image(systemName: "laptopcomputer")
                                .font(.system(size: 50))
                                .foregroundStyle(.gray)
                        }
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
                .width(85)
                TableColumn("Device Name") { hardware in
                    NavigationLink(destination: AssetDetailView(hardwareID: Int32(hardware.id))) {
                        if hardware.name != "" {
                            Text(hardware.name ?? "")
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(hardware.assetTag)
                        }
                    }
                }
                .customizationID("deviceName")
                TableColumn("Asset Tag") { hardware in
                    Text(hardware.assetTag)
                }
                .customizationID("assetTag")
                TableColumn("Serial Number") { hardware in
                    Text(hardware.serial ?? "N/A")
                }
                .customizationID("serialNumber")
                TableColumn("Manufacturer") { hardware in
                    Text(hardware.manufacturer?.name ?? "N/A")
                }
                .customizationID("manufacturer")
                TableColumn("Model Number") { hardware in
                    Text(hardware.modelNumber ?? "N/A")
                }
                .customizationID("modelNumber")
                TableColumn("Category") { hardware in
                    Text(hardware.category?.name ?? "N/A")
                }
                .customizationID("category")
                TableColumn("Location") { hardware in
                    Text(hardware.location?.name ?? "N/A")
                }
                .customizationID("location")
                TableColumn("Assigned To") { hardware in
                    Text(hardware.assignedTo?.name ?? "N/A")
                }
                .customizationID("assignedTo")
                TableColumn("Expected Checkin") { hardware in
                    Text(hardware.expectedCheckin?.formatted ?? "N/A")
                }
                .customizationID("expectedCheckin")
            }

            .onAppear {
                if service.hardwareItems.isEmpty {
                    service.fetchHardware(searchTerm: searchTerm)
                }
            }
            .onSubmit(of: .search) {
                service.fetchHardware(searchTerm: searchTerm)
            }
            .onChange(of: searchTerm) { oldTerm, newTerm in
                service.fetchHardware(searchTerm: newTerm)
            }
            .onChange(of: service.hardwareItems) { oldItems, newItems in
                if newItems.last != nil {
                    DispatchQueue.main.async {
                        if newItems.count < service.hardwareTotal {
                            service.fetchHardware(offset: newItems.count)
                        }
                    }
                }
            }
        }
        .onChange(of: selection) { newSelection in
            isShowingInspector = newSelection != nil
        }
        .alert(item: $service.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Assets"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    service.fetchHardware(searchTerm: searchTerm)
                }),
                secondaryButton: .cancel()
            )
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                if service.isLoading {
                    ProgressView()
                        .scaleEffect(0.6)
                        .progressViewStyle(.circular)
                } else {
                    Button(action: {
                        service.fetchHardware(searchTerm: searchTerm)
                    }, label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    })
                }
            }
        }
        .searchable(text: $searchTerm, prompt: "Search")
    }
}

#Preview {
    AssetTableView()
}
