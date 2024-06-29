//
//  ConsumableListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 26/6/2024.
//

import SwiftUI

struct ConsumablesListView: View {
    @StateObject private var service = SnipeAPIService()
    
    @State private var selection: ConsumableItem.ID?
    
    var body: some View {
        List(service.consumablesItems, selection: $selection) { consumable in
            VStack(alignment: .leading, spacing: 5) {
                Text(consumable.name)
                    .fontWeight(.medium)
                HStack(spacing: 10) {
                    Text(consumable.category.name)
                    Spacer()
                    Text("\(consumable.qty)")
                }
                .font(.callout)
            }
        }
        .overlay {
            if service.consumablesItems.isEmpty {
                ContentUnavailableView("No Consumables Found", systemImage: "drop")
            }
        }
        .onAppear {
            service.fetchAllConsumables()
        }
        .refreshable {
            service.fetchAllConsumables()
        }
        .navigationTitle("Consumables")
    }
}

#Preview {
    ConsumablesListView()
}
