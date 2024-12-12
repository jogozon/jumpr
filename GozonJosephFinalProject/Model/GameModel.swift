//
//  GameModel.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/9/24.
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct GameModel: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var gameName: String
    var size: Int
    @ServerTimestamp var createdDate: Date?
    // [userTeam, opponentTeam]
    var score: [Int]?
    var notes: String?
    var location: String? // points to location database
    
    // A helper to format the date for display
//    func formattedDate() -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//        return formatter.string(from: createdAt)
//    }
}
