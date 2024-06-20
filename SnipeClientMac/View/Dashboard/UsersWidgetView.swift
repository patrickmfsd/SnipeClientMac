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
        GroupBox {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Recent Users")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("\(service.hardwareTotal) Assets")
                        .foregroundStyle(.secondary)
                }.padding(10)
                if service.userItem.isEmpty {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 10) {
                            Image(systemName: "person.slash")
                                .font(.largeTitle)
                            Text("Users Unavailable")
                                .font(.title2)
                        }
                        Spacer()
                    }
                    .padding()
                } else {
                    ForEach(service.userItem.prefix(5)) { users in
                        Divider()
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(users.firstName) \(users.lastName)")
                                Text("Total Assets: \(service.userTotal)")
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                service.fetchUsers()
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .thin))
        .frame(minWidth: 320, maxWidth: 500)
    }
}

#Preview {
    UsersWidgetView()
}
