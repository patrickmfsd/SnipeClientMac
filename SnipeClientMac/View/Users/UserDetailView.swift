    //
    //  UserDetailView.swift
    //  SnipeManager
    //
    //  Created by Patrick Mifsud on 21/10/2024.
    //

import SwiftUI

struct UserDetailView: View {
    @StateObject private var service = SnipeAPIService()
    
    var userID: Int32
    
    var body: some View {
        VStack {
            UserHeader(userID: userID)
            UserAssets(userID: userID)
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

struct UserHeader: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @StateObject private var service = SnipeAPIService()
    
    var userID: Int32
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            image
            text
            Spacer()
        }
        .padding()
        .onAppear {
            service.fetchUser(id: userID)
        }
    }
    
    var image: some View {
        AsyncImage(url: URL(string: service.user?.avatar ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 80, maxWidth: 180, minHeight: 80, maxHeight: 180)
        } placeholder: {
            Image(systemName: "person.fill")
                .foregroundStyle(.gray.secondary)
                .font(.system(size: 100))
                .frame(minWidth: 80, maxWidth: 180, minHeight: 80, maxHeight: 180)
        }
        .background(.white)
        .clipShape(Circle())
    }
    
    var text: some View {
        VStack(spacing: 10) {
            if let user = service.user {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .center, spacing: 5) {
                        Text(user.firstName)
                            .font(.title)
                        Text(user.lastName ?? "")
                            .font(.title)
                    }
                    HStack {
                        if let jobTitle = user.jobTitle {
                            Text(jobTitle)
                        }
                        if let department = user.department?.name {
                            Text(department)
                        }
                        if let company = user.company?.name {
                            Text(company)
                        }
                    }
                    .font(.title2)
                    .foregroundColor(.secondary)
                    if !user.username.isEmpty {
                        Text(user.username)
                            .font(.title3)
                            .foregroundColor(.secondary)
                    } else {
                        if let employeeNumber = user.employeeNum {
                            Text(employeeNumber)
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else {
                Text("Loading user data...")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct UserAssets: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @StateObject private var service = SnipeAPIService()
    
    var userID: Int32
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 10) {
                Text("Assets")
                    .font(.title2)
                    .fontWeight(.semibold)
                if service.hardwareItems.isEmpty {
                    ContentUnavailableView(
                        "No Assets",
                        systemImage: "laptopcomputer.slash",
                        description: Text("No Assets Checked Out")
                    )
                    .frame(maxWidth: .infinity)
                } else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(service.hardwareItems.prefix(25)) { hardware in
                                NavigationLink(destination:  AssetDetailView(hardwareID: Int32(hardware.id))) {
                                    AssetItem(hardware: hardware, size: 60)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .onAppear {
                service.fetchUserAssets(id: userID)
            }
        }
    }
}
