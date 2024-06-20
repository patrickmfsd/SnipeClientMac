//
//  ComponentsTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 20/6/2024.
//

import SwiftUI

struct ComponentsTableView: View {
    @StateObject private var viewModel = SnipeAPIService()
    
    @SceneStorage("ComponentsTableConfig")
    private var columnCustomization: TableColumnCustomization<Component>
    
    @State private var selection: Component.ID?
    
    var body: some View {
        VStack {
            if let error = viewModel.errorMessage {
                Text("Error: \(error.message)")
                    .foregroundColor(.red)
            } else {
                Table(viewModel.components, selection: $selection, columnCustomization: $columnCustomization) {
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
                        Text("\(component.serial)")
                    }
                    .customizationID("serial")
                    TableColumn("Quantity") { component in
                        Text("\(component.qty)")
                    }
                    .customizationID("qty")
                    TableColumn("Order Number") { component in
                        Text("\(component.orderNumber)")
                    }
                    .customizationID("orderNumber")
                    TableColumn("Remaining") { component in
                        Text("\(component.remaining)")
                    }
                    .customizationID("remaining")
                    TableColumn("Supplier") { component in
                        Text("\(component.supplier)")
                    }
                    .customizationID("supplier")
                    TableColumn("Purchase Date") { component in
                        Text("\(component.purchaseDate)")
                    }
                    .customizationID("purchaseDate")
                    TableColumn("Purchase Cost") { component in
                        Text("\(component.purchaseCost)")
                    }
                    .customizationID("purchaseCost")
                }
            }
        }
        .onAppear {
            viewModel.fetchAllComponents()
        }
        .refreshable {
            viewModel.fetchAllComponents()
        }
        .alert(item: $viewModel.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Components"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    viewModel.fetchAllComponents()
                }),
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    ComponentsTableView()
}
