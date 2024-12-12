//
//  CourtModel.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/10/24.
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct CourtModel: Identifiable, Hashable, Codable {
    static func == (lhs: CourtModel, rhs: CourtModel) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(latitude)
            hasher.combine(longitude)
        }
    @DocumentID var id: String?
    var name: String
    var userId: String
    var latitude: Double
    var longitude: Double
}

