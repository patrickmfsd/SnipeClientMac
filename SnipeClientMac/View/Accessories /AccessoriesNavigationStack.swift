//
//  AccessoriesNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 22/7/2024.
//

import SwiftUI

struct AccessoriesNavigationStack: View {
    var body: some View {
        NavigationStack {
            Group {
                #if os(iOS)
                AccessoriesListView()
                #else
                AccessoriesTableView()
                #endif
            }
            .navigationTitle("Accessories")
        }
    }
}

#Preview {
    AccessoriesNavigationStack()
}
