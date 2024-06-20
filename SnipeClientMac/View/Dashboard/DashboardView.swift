//
//  DashboardView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct DashboardView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 300, maximum: 520)),
        GridItem(.adaptive(minimum: 300, maximum: 520)),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                AssetWidget()
                UsersWidgetView()
            }
            .padding()
        }
    }
}

#Preview {
    DashboardView()
}
