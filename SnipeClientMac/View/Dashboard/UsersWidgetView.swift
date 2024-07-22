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
                ForEach(service.userItem.prefix(5)) { users in
                    Divider()
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            AsyncImage(url: URL(string: users.avatar ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            } placeholder: {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 45))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 55, height: 55)
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
                        .frame(height: 80)
                    }
                }
            }
        }
        .onAppear {
            service.fetchUsers()
        }
    }
}

#Preview {
    UsersWidgetView()
}
