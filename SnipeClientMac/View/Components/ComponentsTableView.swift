//
//  ComponentsTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 20/6/2024.
//

import SwiftUI

struct ComponentsTableView: View {
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("ComponentsTableConfig")
    private var columnCustomization: TableColumnCustomization<Component>
    
    @State private var selection: Component.ID?
    
    var body: some View {
        VStack {
            if let error = service.errorMessage {
                Text("Error: \(error.message)")
                    .foregroundColor(.red)
            } else {
                Table(service.components, selection: $selection, columnCustomization: $columnCustomization) {
                    TableColumn("Image") { component in
                        AsyncImage(url: URL(string: component.image ?? "")) { image in
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
                    TableColumn("Name") { component in
                        Text("\(component.name)")
                    }
                    .customizationID("name")
                    TableColumn("Serial") { component in
                        Text("\(component.serial ?? "Unknown")")
                    }
                    .customizationID("serial")
                    TableColumn("Quantity") { component in
                        Text("\(component.qty)")
                    }
                    .customizationID("qty")
                    TableColumn("Order Number") { component in
                        Text("\(component.orderNumber ?? "Unknown")")
                    }
                    .customizationID("orderNumber")
                    TableColumn("Remaining") { component in
                        Text("\(component.remaining)")
                    }
                    .customizationID("remaining")
                    TableColumn("Supplier") { component in
                        Text("\(component.supplier ?? "Unknown")")
                    }
                    .customizationID("supplier")
                    TableColumn("Purchase Date") { component in
                        Text("\(component.purchaseDate ?? "Unknown")")
                    }
                    .customizationID("purchaseDate")
                    TableColumn("Purchase Cost") { component in
                        Text("\(component.purchaseCost ?? "Unknown")")
                    }
                    .customizationID("purchaseCost")
                }
            }
        }
        .onAppear {
            service.fetchAllComponents()
        }
        .refreshable {
            service.fetchAllComponents()
        }
        .alert(item: $service.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Components"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    service.fetchAllComponents()
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
                        service.fetchAllComponents()
                    }, label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    })
                }
            }
        }
    }
}

#Preview {
    ComponentsTableView()
}
