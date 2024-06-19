//
//  ComponentsListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 19/6/2024.
//

import SwiftUI

struct ComponentsListView: View {
    @StateObject private var viewModel = SnipeAPIService()
    
    @State private var selection: Component.ID?
    
    var body: some View {
        List(viewModel.components, selection: $selection) { component in
            Text(component.name)
        }
        .onAppear {
            viewModel.fetchAllComponents()
        }
        .refreshable {
            viewModel.fetchAllComponents()
        }
        .navigationTitle("Components")
    }
}

#Preview {
    ComponentsListView()
}
