//
//  UserListView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = SnipeAPIService()
    
    var body: some View {
        List(viewModel.userItem) { user in
            UserRowView(
                fName: user.firstName,
                lName: user.lastName,
                employeeNum: user.employeeNum
            )
        }
        .onAppear {
            viewModel.fetchUsers()
        }
        .refreshable {
            viewModel.fetchUsers()
        }
    }
}
    
struct UserRowView: View {
    var fName: String
    var lName: String
    var employeeNum: String
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Text("\(fName) \(lName)")
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
