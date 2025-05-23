//
//  UsersNavigationStack.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import SwiftUI

struct UsersNavigationStack: View {
    var body: some View {
        NavigationStack {
            Group {
                #if os(iOS)
                UserListView()
                #else
                UserTableView()
                #endif
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    UsersNavigationStack()
}
