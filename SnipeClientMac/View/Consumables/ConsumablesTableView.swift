//
//  ConsumablesTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 25/6/2024.
//

import SwiftUI

struct ConsumablesTableView: View {
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("ConsumablesTableConfig") private var columnCustomization: TableColumnCustomization<ConsumableItem>
    
    @State private var selection: Component.ID?
    @State private var searchTerm: String = ""
    
    var body: some View {
        VStack {
            Table(service.consumablesItems, selection: $selection, columnCustomization: $columnCustomization) {
                TableColumn("Image") { consumables in
                    AsyncImage(url: URL(string: consumables.image ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                    } placeholder: {
                        Image(systemName: "drop.halffull")
                            .font(.system(size: 50))
                    }
                }
                .width(85)
                .customizationID("image")
                TableColumn("Name") { consumables in
                    Text("\(consumables.name)")
                }
                .customizationID("name")
                TableColumn("Item Number") { consumables in
                    Text("\(consumables.itemNo ?? "")")
                }
                .customizationID("serial")
                TableColumn("Quantity") { consumables in
                    Text("\(consumables.qty ?? 0)")
                }
                .customizationID("qty")
                TableColumn("Order Number") { consumables in
                    Text("\(consumables.orderNumber ?? "Unknown")")
                }
                .customizationID("orderNumber")
                TableColumn("Remaining") { consumables in
                    Text("\(consumables.remaining ?? 0)")
                }
                .customizationID("remaining")
                TableColumn("Supplier") { consumables in
                    Text("\(consumables.supplier?.name ?? "Unknown")")
                }
                .customizationID("supplier")
                TableColumn("Purchase Date") { consumables in
                    Text("\(consumables.purchaseDate?.formatted ?? "Unknown")")
                }
                .customizationID("purchaseDate")
                TableColumn("Purchase Cost") { consumables in
                    Text("\(consumables.purchaseCost ?? "Unknown")")
                }
                .customizationID("purchaseCost")
            }
            .onAppear {
                if service.consumablesItems.isEmpty {
                    service.fetchAllConsumables(searchTerm: searchTerm)
                }
            }
            .onSubmit(of: .search) {
                service.fetchAllConsumables(searchTerm: searchTerm)
            }
            .onChange(of: searchTerm) { oldTerm, newTerm in
                service.fetchAllConsumables(searchTerm: newTerm)
            }
            .onChange(of: service.consumablesItems) { oldItems, newItems in
                if newItems.last != nil {
                    DispatchQueue.main.async {
                        if newItems.count < service.consumablesTotal {
                            service.fetchAllConsumables(offset: newItems.count)
                        }
                    }
                }
            }
        }
        .alert(item: $service.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Consumables"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    service.fetchAllConsumables()
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
                        service.fetchAllConsumables()
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
    ConsumablesTableView()
}
