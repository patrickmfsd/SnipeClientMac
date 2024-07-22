//
//  AccessoriesTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 22/7/2024.
//

import SwiftUI

struct AccessoriesTableView: View {
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("AccessoriesTableConfig") private var columnCustomization: TableColumnCustomization<Accessory>
    
    @State private var selection: Maintenance.ID?
    @State private var searchTerm: String = ""
    
    var body: some View {
        VStack {
            Table(service.accessoriesItems, selection: $selection, columnCustomization: $columnCustomization) {
                TableColumn("Image") { accessory in
                    AsyncImage(url: URL(string: accessory.image ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                    } placeholder: {
                        Image(systemName: "cpu")
                            .font(.system(size: 50))
                    }
                }
                .width(85)
                TableColumn("Name") { accessory in
                    Text("\(accessory.name)")
                }
                .customizationID("name")
                TableColumn("Quantity") { accessory in
                    Text("\(accessory.qty ?? 0)")
                }
                .customizationID("quantity")
                TableColumn("Order Number") { accessory in
                    Text("\(accessory.orderNumber ?? "Unknown")")
                }
                .customizationID("orderNumber")
                TableColumn("Remaining") { accessory in
                    Text("\(accessory.remainingQty ?? 0)")
                }
                .customizationID("remaining")
                TableColumn("Supplier") { accessory in
                    Text("\(accessory.supplier?.name ?? "Unknown")")
                }
                .customizationID("supplier")
                TableColumn("Purchase Date") { accessory in
                    Text("\(accessory.purchaseDate ?? "Unknown")")
                }
                .customizationID("purchaseDate")
                TableColumn("Purchase Cost") { accessory in
                    Text("\(accessory.purchaseCost ?? "Unknown")")
                }
                .customizationID("purchaseCost")
            }
            .onAppear {
                if service.accessoriesItems.isEmpty {
                    service.fetchAllAccessories(searchTerm: searchTerm)
                }
            }
            .onSubmit(of: .search) {
                service.fetchAllAccessories(searchTerm: searchTerm)
            }
            .onChange(of: searchTerm) { oldTerm, newTerm in
                service.fetchAllAccessories(searchTerm: newTerm)
            }
            .onChange(of: service.accessoriesItems) { oldItems, newItems in
                if newItems.last != nil {
                    DispatchQueue.main.async {
                        if newItems.count < service.accessoriesTotal {
                            service.fetchAllAccessories(offset: newItems.count)
                        }
                    }
                }
            }
        }
        .alert(item: $service.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Maintenances"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    service.fetchAllAccessories()
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
                        service.fetchAllAccessories()
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
    AccessoriesTableView()
}
