//
//  UsersWidgetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct UsersWidgetView: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        GroupBox(label:
                    Text("Recent Users")
            .font(.title2)
            .fontWeight(.medium)
        ) {
            if service.userItem.isEmpty {
                ContentUnavailableView(
                    "Users Unavailable",
                    systemImage: "person.fill.questionmark"
                )
                .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(service.userItem.prefix(5)) { users in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(users.firstName) \(users.lastName)")
                                Text("Total Assets: \(service.userTotal)")
                            }
                            Spacer()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .frame(height: 600)
        .onAppear {
            service.fetchUsers()
        }
    }
}

#Preview {
    UsersWidgetView()
}
