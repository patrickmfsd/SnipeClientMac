//
//  ConsumableListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 26/6/2024.
//

import SwiftUI

struct ConsumableListView: View {
    @StateObject private var service = SnipeAPIService()
    
    @State private var selection: ConsumableItem.ID?
    
    var body: some View {
        List(service.consumablesItems, selection: $selection) { consumable in
            Text(consumable.name)
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
    ConsumableListView()
}
