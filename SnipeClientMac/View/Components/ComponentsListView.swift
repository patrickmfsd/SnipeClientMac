//
//  ComponentsListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 19/6/2024.
//

import SwiftUI

struct ComponentsListView: View {
    @StateObject private var service = SnipeAPIService()
    
    @State private var selection: Component.ID?
    
    var body: some View {
        List(service.components, selection: $selection) { component in
            VStack(alignment: .leading, spacing: 5) {
                Text(component.name)
                    .fontWeight(.medium)
                HStack(spacing: 10) {
                    Text(component.category.name)
                    Spacer()
                    Text("\(component.qty)")
                }
                .font(.callout)
            }
        }
        .onAppear {
            service.fetchAllComponents()
        }
        .refreshable {
            service.fetchAllComponents()
        }
        .navigationTitle("Components")
    }
}

#Preview {
    ComponentsListView()
}
