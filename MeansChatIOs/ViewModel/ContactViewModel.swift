//
//  ContactViewModel.swift
//  MeansChatIOs
//
//  Created by apple on 28/11/24.
//

import Foundation
import SwiftUI
import Contacts

class ContactViewModel: ObservableObject {
    func requestAccessToContacts(completion: @escaping (Bool) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func fetchContactsAsync(completion: @escaping ([Contact]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let store = CNContactStore()
            let keysToFetch = [
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactImageDataKey,
                CNContactPhoneNumbersKey
            ] as [CNKeyDescriptor]

            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            var contacts: [Contact] = []

            do {
                try store.enumerateContacts(with: request) { contact, _ in
                    let fullName = "\(contact.givenName) \(contact.familyName)"
                    let image = contact.imageData != nil ? UIImage(data: contact.imageData!) : nil
                    let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
                    contacts.append(Contact(fullName: fullName, phoneNumbers: phoneNumbers, profileImage: image))
                }

                // Switch back to the main thread to update UI
                DispatchQueue.main.async {
                    completion(contacts)
                }
            } catch {
                print("Failed to fetch contacts:", error)
                DispatchQueue.main.async {
                    completion([]) // Return empty array on failure
                }
            }
        }
    }


}
