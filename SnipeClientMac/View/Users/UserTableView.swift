//
//  UserTableView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import SwiftUI

struct UserTableView: View {
    @StateObject private var service = SnipeAPIService()
    
    @SceneStorage("AssetTableConfig")
    private var columnCustomization: TableColumnCustomization<User>
    
    @State private var selection: User.ID?
    @State private var searchTerm: String = ""
    
    var body: some View {
        VStack {
            Table(service.users, selection: $selection, columnCustomization: $columnCustomization) {
                TableColumn("Profile") { user in
                    AsyncImage(url: URL(string: user.avatar ?? "")) { image in
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
                    .clipShape(Circle())
                }
                .width(60)
                TableColumn("First Name") { user in
                    NavigationLink(
                        destination: UserDetailView(userID: Int32(user.id))
                    ) {
                        Text(user.firstName)
                    }
                }
                .customizationID("firstName")
                TableColumn("Last Name") { user in
                    Text(user.lastName ?? "")
                }
                .customizationID("lastName")
                TableColumn("Date Created") { user in
                    Text(user.createdAt?.datetime ?? "")
                }
                .customizationID("employeeNum")
                TableColumn("ID Number") { user in
                    Text(user.employeeNum  ?? "")
                }
                .customizationID("employeeNum")
                TableColumn("Username") { user in
                    Text(user.username)
                }
                .customizationID("username")
                TableColumn("Email") { user in
                    Text("\(user.email ?? "No Email")")
                }
                .customizationID("email")
                TableColumn("Assets") { user in
                    Text("\(user.assetsCount)")
                }
                .customizationID("assetsCount")
                TableColumn("Licenses") { user in
                    Text("\(user.licensesCount)")
                }
                .customizationID("licensesCount")
                TableColumn("Consumables") { user in
                    Text("\(user.consumablesCount)")
                }
                .customizationID("consumablesCount")
            }
            .onAppear {
                if service.users.isEmpty {
                    service.fetchUsers()
                }
            }
            .onSubmit(of: .search) {
                service.fetchUsers(searchTerm: searchTerm)
            }
            .onChange(of: searchTerm) { oldTerm, newTerm in
                service.fetchUsers(searchTerm: searchTerm)
            }
            .onChange(of: service.users) { oldItems, newItems in
                if newItems.last != nil {
                    DispatchQueue.main.async {
                        if newItems.count < service.userTotal {
                            service.fetchUsers(offset: newItems.count)
                        }
                    }
                }
            }
        }
        .alert(item: $service.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Users"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    service.fetchUsers()
                }),
                secondaryButton: .cancel()
            )
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                if service.isLoading {
                    ProgressView()
                        .scaleEffect(0.6)
                        .progressViewStyle(.circular)
                } else {
                    Button(action: {
                        service.fetchUsers()
                    }, label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    })
                }
            }
        }
        .searchable(text: $searchTerm, prompt: "Search")
    }
}

#Preview {
    UserTableView()
}
