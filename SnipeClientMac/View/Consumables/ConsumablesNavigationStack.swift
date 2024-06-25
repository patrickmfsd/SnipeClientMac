//
//  ConsumablesNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 25/6/2024.
//

import SwiftUI

struct ConsumablesNavigationStack: View {
    var body: some View {
        NavigationStack {
            Group {
                #if os(iOS)
                ConsumablesListView()
                #else
                ConsumablesTableView()
                #endif
            }
            .navigationTitle("Consumables")
        }
    }
}

#Preview {
    ConsumablesNavigationStack()
}
