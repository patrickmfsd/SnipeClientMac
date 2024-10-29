//
//  UsersWidgetView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct UsersCard: View {
    @StateObject private var service = SnipeAPIService()
    
    let rows = [
        GridItem(.fixed(85)),
        GridItem(.fixed(85)),
        GridItem(.fixed(85))
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Users")
                .font(.title2)
                .fontWeight(.medium)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 10) {
                    ForEach(service.users.prefix(25)) { user in
                        NavigationLink(destination: EmptyView()) {
                            UserItemView(user: user)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, -16)
        }
        .padding(.horizontal)
        .onAppear {
            service.fetchUsers()
        }
    }
}

struct UserItemView: View {
    @State var user: User

    var body: some View {
        GroupBox {
            HStack(spacing: 12) {
                image
                details
            }
            .frame(width: 300, height: 70)
        }
        .groupBoxStyle(
            CustomGroupBox(
                spacing: 8,
                radius: 8,
                background: .color(.secondary.opacity(0.1))
            )
        )
    }
    
    var image: some View {
        AsyncImage(url: URL(string: user.avatar ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        } placeholder: {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
        }
    }
    
    var details: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(user.name)")
                    .font(.headline)
                if let userCode = user.employeeNum {
                    Text("\(userCode)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                Text("Assets: \(user.assetsCount)")
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.tint)
                .font(.system(size: 16))
        }
    }
}

#Preview {
    UsersCard()
}
