//
//  ComponentsTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 20/6/2024.
//

import SwiftUI

struct ComponentsTableView: View {
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("ComponentsTableConfig") private var columnCustomization: TableColumnCustomization<Component>
    
    @State private var selection: Component.ID?
    @State private var searchTerm: String = ""

    var body: some View {
        VStack {
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
                TableColumn("Name") { component in
                    Text("\(component.name)")
                }
                .customizationID("name")
                TableColumn("Serial") { component in
                    Text("\(component.serial ?? "Unknown")")
                }
                .customizationID("serial")
                TableColumn("Quantity") { component in
                    Text("\(component.qty ?? 0)")
                }
                .customizationID("quantity")
                TableColumn("Order Number") { component in
                    Text("\(component.orderNumber ?? "Unknown")")
                }
                .customizationID("orderNumber")
                TableColumn("Remaining") { component in
                    Text("\(component.remaining ?? 0)")
                }
                .customizationID("remaining")
                TableColumn("Supplier") { component in
                    Text("\(component.supplier?.name ?? "Unknown")")
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
            .onAppear {
                if service.components.isEmpty {
                    service.fetchAllComponents(searchTerm: searchTerm)
                }
            }
            .onSubmit(of: .search) {
                service.fetchAllComponents(searchTerm: searchTerm)
            }
            .onChange(of: searchTerm) { oldTerm, newTerm in
                service.fetchAllComponents(searchTerm: newTerm)
            }
            .onChange(of: service.components) { oldItems, newItems in
                if newItems.last != nil {
                    DispatchQueue.main.async {
                        if newItems.count < service.componentsTotal {
                            service.fetchAllComponents(offset: newItems.count)
                        }
                    }
                }
            }
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
        .searchable(text: $searchTerm, prompt: "Search")
    }
}

#Preview {
    ComponentsTableView()
}
