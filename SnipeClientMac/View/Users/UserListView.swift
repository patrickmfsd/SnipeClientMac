//
//  UserListView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var service = SnipeAPIService()
    
    @State private var searchTerm: String = ""

    var body: some View {
        List(service.users) { users in
            NavigationLink(
                destination: UserDetailView(userID: Int32(users.id))
            ) {
                HStack {
                    AsyncImage(url: URL(string: users.avatar ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 25))
                            .foregroundStyle(.gray)
                    }
                    .frame(width: 50, height: 50)
                    .background(.white)
                    .clipShape(.circle)
                    VStack(alignment: .leading) {
                        Text("\(users.name)")
                            .font(.headline)
                        if let usersCode = users.employeeNum {
                            Text("\(usersCode)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                        Text("Assets: \(users.assetsCount)")
                    }
                    Spacer()
                }
            }
            .onAppear {
                if users == service.users.last {
                    service.fetchUsers(offset: service.users.count)
                }
            }
        }
        .onAppear {
            service.fetchUsers()
        }
        .refreshable {
            service.fetchUsers()
        }
        .onSubmit(of: .search) {
            service.fetchUsers(searchTerm: searchTerm)
        }
        .onChange(of: searchTerm) { oldTerm, newTerm in
            service.fetchUsers(searchTerm: searchTerm)
        }
        .searchable(text: $searchTerm, prompt: "Search")
    }
}
    
struct UserRowView: View {
    var name: String
    var employeeNum: String
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Text("\(name)")
                Text("\(employeeNum)")
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    UserListView()
}
