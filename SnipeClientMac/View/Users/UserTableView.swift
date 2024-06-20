//
//  UserTableView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import SwiftUI

struct UserTableView: View {
    @StateObject private var viewModel = SnipeAPIService()
    
    @SceneStorage("AssetTableConfig")
    private var columnCustomization: TableColumnCustomization<User>
    
    @State private var selection: User.ID?
    
    var body: some View {
        VStack {
            if let error = viewModel.errorMessage {
                Text("Error: \(error.message)")
                    .foregroundColor(.red)
            } else {
                Table(viewModel.userItem, selection: $selection, columnCustomization: $columnCustomization) {
                    TableColumn("First Name") { user in
                        Text(user.firstName)
                    }
                    .customizationID("firstName")
                    TableColumn("Last Name") { user in
                        Text(user.lastName)
                    }
                    .customizationID("lastName")
                    TableColumn("Employee Number") { user in
                        Text(user.employeeNum)
                    }
                    .customizationID("employeeNum")
                    TableColumn("Username") { user in
                        Text(user.username)
                    }
                    .customizationID("username")
                    TableColumn("Email") { user in
                        Text("\(user.email)")
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
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
        .refreshable {
            viewModel.fetchUsers()
        }
        .alert(item: $viewModel.errorMessage) { error in
            Alert(
                title: Text("Unable to retrieve Users"),
                message: Text(error.message),
                primaryButton: .default(Text("Retry"), action: {
                    viewModel.fetchUsers()
                }),
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    UserTableView()
}
