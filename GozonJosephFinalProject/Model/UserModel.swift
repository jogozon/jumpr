//
//  UserModel.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/9/24.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable {
    @DocumentID var uid: String?
    var firstName: String
    var lastName: String
    var displayName: String
    var email: String
    var profileUrl: String?
    var courtLocations: [String]?
    var games: [String]?
}
