//
//  UserListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var service = SnipeAPIService()
    
    @State private var searchTerm: String = ""

    var body: some View {
        List(service.userItem) { users in
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
            .onAppear {
                if users == service.userItem.last {
                    service.fetchUsers(offset: service.userItem.count)
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
