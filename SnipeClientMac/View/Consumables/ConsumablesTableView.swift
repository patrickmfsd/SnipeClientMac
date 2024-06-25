//
//  ConsumablesTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 25/6/2024.
//

import SwiftUI

struct ConsumablesTableView: View {
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("ConsumablesTableConfig")
    private var columnCustomization: TableColumnCustomization<ConsumableItem>
    
    @State private var selection: Component.ID?
    
    var body: some View {
        VStack {
            if let error = service.errorMessage {
                Text("Error: \(error.message)")
                    .foregroundColor(.red)
            } else {
                Table(service.consumablesItems, selection: $selection, columnCustomization: $columnCustomization) {
                    TableColumn("Image") { consumables in
                        AsyncImage(url: URL(string: consumables.image ?? "")) { image in
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
                    .customizationID("image")
                    TableColumn("Name") { consumables in
                        Text("\(consumables.name)")
                    }
                    .customizationID("name")
                    TableColumn("Item Number") { consumables in
                        Text("\(consumables.itemNo)")
                    }
                    .customizationID("serial")
                    TableColumn("Quantity") { consumables in
                        Text("\(consumables.qty)")
                    }
                    .customizationID("qty")
                    TableColumn("Order Number") { consumables in
                        Text("\(consumables.orderNumber)")
                    }
                    .customizationID("orderNumber")
                    TableColumn("Remaining") { consumables in
                        Text("\(consumables.remaining)")
                    }
                    .customizationID("remaining")
                    TableColumn("Supplier") { consumables in
                        Text("\(consumables.supplier)")
                    }
                    .customizationID("supplier")
                    TableColumn("Purchase Date") { consumables in
                        Text("\(consumables.purchaseDate)")
                    }
                    .customizationID("purchaseDate")
                    TableColumn("Purchase Cost") { consumables in
                        Text("\(consumables.purchaseCost)")
                    }
                    .customizationID("purchaseCost")
                }
            }
        }
        .onAppear {
            service.fetchAllConsumables()
        }
        .refreshable {
            service.fetchAllConsumables()
        }
        .overlay {
            if service.consumablesItems.isEmpty {
                ContentUnavailableView("No Consumables Found", systemImage: "drop")
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
                Button(action: {
                    service.fetchAllConsumables()
                }, label: {
                    Label("Refresh", systemImage: "arrow.clockwise")
                })
            }
        }
    }
}

#Preview {
    ConsumablesTableView()
}
