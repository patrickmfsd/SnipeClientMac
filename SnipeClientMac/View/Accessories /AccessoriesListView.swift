//
//  AccessoriesListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 22/7/2024.
//

import SwiftUI

struct AccessoriesListView: View {
    @StateObject private var service = SnipeAPIService()
    
    @State private var selection: Maintenance.ID?
    
    var body: some View {
        List(service.accessoriesItems, selection: $selection) { accessory in
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: accessory.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .padding(5)
                        .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                } placeholder: {
                    Image(systemName: "shippingbox")
                        .font(.system(size: 50))
                }
                VStack(alignment: .leading) {
                    Text(accessory.name)
                        .font(.headline)
                    Text("\(accessory.manufacturer?.name ?? "") - \(accessory.modelNumber ?? "")")
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .frame(height: 80)
            .onAppear {
                if accessory == service.accessoriesItems.last {
                    service
                        .fetchAllAccessories(
                            offset: service.accessoriesItems.count
                        )
                }
            }
            
        }
        .onAppear {
            service.fetchAllAccessories()
        }
        .refreshable {
            service.fetchAllAccessories()
        }
        .navigationTitle("Accessories")
    }
}

#Preview {
    AccessoriesListView()
}
