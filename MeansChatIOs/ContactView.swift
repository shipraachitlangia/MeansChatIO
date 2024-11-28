//
//  ContactView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct ContactView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var contacts: [Contact] = []
    @State private var hasAccess = true
    @ObservedObject private var viewModel = ContactViewModel()
    @State private var filteredContacts: [Contact] = []
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .padding()
                            .foregroundStyle(.white)
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color(.SubTitleColor), lineWidth: 1)
                            )
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField(
                    "",
                    text: $searchText,
                    prompt: Text("Search users")
                        .foregroundColor(Color(.SubTitleColor))
                    
                )
                .foregroundColor(Color(.white))
                .padding()
                .background(Color(.TextFieldBgColor))
                
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.SubTitleColor), lineWidth: 2)
                )
                .padding()
                
                if hasAccess {
                    List(filteredContacts) { contact in
                        HStack {
                            if let profileImage = contact.profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                                    .overlay(Text("No\nImage").font(.caption).foregroundColor(.white))
                            }
                            
                            Text(contact.fullName)
                                .font(.headline)
                                .padding(.leading, 10)
                                .foregroundColor(.white)
                            
                        }
                        .listRowBackground(Color(.BackgroundColor))
                    }
                    .listStyle(.plain)
                    .background(Color(.BackgroundColor))
                    
                } else {
                    Text("Access to contacts is denied.")
                }
                
                Spacer()
            }
            .onChange(of: searchText) { newValue in
                filterContacts()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color(.BackgroundColor))
            .onAppear {
                viewModel.requestAccessToContacts { granted in
                    self.hasAccess = granted
                    if granted {
                        viewModel.fetchContactsAsync { fetchedContacts in
                            self.contacts = fetchedContacts
                            self.filteredContacts = fetchedContacts
                        }
                    }
                }
            }
        }
    }
    
    func filterContacts() {
        if searchText.isEmpty {
            filteredContacts = contacts
        } else {
            filteredContacts = contacts.filter {
                $0.fullName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    ContactView()
}
