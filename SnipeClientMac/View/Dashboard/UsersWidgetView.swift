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
                    ForEach(service.userItem.prefix(10)) { users in
                        HStack {
                            AsyncImage(url: URL(string: users.avatar ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            } placeholder: {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 50))
                            }
                            .frame(width: 60, height: 60)
                            .padding(5)
                            .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                            VStack(alignment: .leading) {
                                Text("\(users.name)")
                                    .font(.headline)
                                if let usersCode = users.employeeNum {
                                    Text("\(usersCode)")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                }
                                Text("Assets: \(users.assetsCount)")
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
