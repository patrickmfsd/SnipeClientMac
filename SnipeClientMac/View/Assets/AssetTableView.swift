//
//  AssetTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct AssetTableView: View {
    @Environment(\.openWindow) private var openWindow
    
    @StateObject private var viewModel = SnipeAPIService()
    
    @SceneStorage("AssetTableConfig") private var columnCustomization: TableColumnCustomization<HardwareItem>
    
    @State private var isShowingInspector = false

    @State private var selection: HardwareItem.ID?
    
    @State var id: Int32 = 0
    
    var body: some View {
        Table(viewModel.hardwareItems, selection: $selection, columnCustomization: $columnCustomization) {
            TableColumn("Image") { hardware in
                AsyncImage(url: URL(string: hardware.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                } placeholder: {
                    Image(systemName: "laptopcomputer")
                        .font(.system(size: 50))
                }
            }
            .width(85)
            TableColumn("Device Name") { hardware in
                NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
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
                Text(hardware.expectedCheckin ?? "N/A")
            }
            .customizationID("expectedCheckin")
            
        }
        .onAppear {
            viewModel.fetchHardware()
        }
        .refreshable {
            viewModel.fetchHardware()
        }
        .alert(item: $viewModel.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Assets"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    viewModel.fetchHardware()
                }),
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    AssetTableView()
}
