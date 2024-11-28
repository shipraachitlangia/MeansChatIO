//
//  Contact.swift
//  MeansChatIOs
//
//  Created by apple on 28/11/24.
//

import Foundation
import UIKit

struct Contact: Identifiable {
    let id = UUID()
    //let givenName: String
   // let familyName: String
    let fullName: String
    let phoneNumbers: [String]
    var profileImage: UIImage?
}
