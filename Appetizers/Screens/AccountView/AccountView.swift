//
//  AccountView.swift
//  Appetizers
//
//  Created by Phoon Thet Pine on 9/4/24.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("First Name", text: $viewModel.user.firstName)
                    TextField("Last Name", text: $viewModel.user.lastName)
                    TextField("Email", text: $viewModel.user.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                    DatePicker("Birthday", selection: $viewModel.user.birthdate,
                               displayedComponents: .date)
                    
                    Button {
                        viewModel.saveChanges()
                    } label: {
                        Text("Save Changes")
                    }
                }
                
                Section(header: Text("Request")) {
                    Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
                    
                    Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
                }
                .toggleStyle(SwitchToggleStyle(tint: .brandPrimary1))
            }
            .navigationTitle("Account")
        }
        .onAppear {
            viewModel.retrieveUser()
        }
        .alert(item: $viewModel.alertItem) { alerItem in
            Alert(title: alerItem.title,
                  message: alerItem.message,
                  dismissButton: alerItem.dismissButton)
        }
    }
}

#Preview {
    AccountView()
}
