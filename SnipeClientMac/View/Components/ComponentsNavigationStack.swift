//
//  ComponentsNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 19/6/2024.
//

import SwiftUI

struct ComponentsNavigationStack: View {
    var body: some View {
        NavigationStack {
            Group {
                #if os(iOS)
                ComponentsListView()
                #else
                ComponentsListView()
                #endif
            }
            .navigationTitle("Components")
        }
    }
}

#Preview {
    UsersNavigationStack()
}
