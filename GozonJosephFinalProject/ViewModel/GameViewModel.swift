//
//  GameViewModel.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/11/24.
//

import Foundation
import FirebaseFirestore
import Combine

class GameViewModel: ObservableObject {
    @Published var games: [GameModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    
    // Add a new game with specific parameters
    func addGame(
        userId: String,
        gameName: String,
        size: Int,
        score: [Int]? = nil,
        notes: String? = nil,
        location: String? = nil
    ) {
        let newGame = GameModel(
            id: nil,
            userId: userId,
            gameName: gameName,
            size: size,
            score: score,
            notes: notes,
            location: location
        )
        
        do {
            _ = try COLLECTION_GAMES.addDocument(from: newGame)
            print("game added successfully")
        } catch {
            print("Error adding game: \(error.localizedDescription)")
        }
    }
    
    // Update an existing game with new parameters
    func updateGame(
        id: String,
        gameName: String? = nil,
        size: Int? = nil,
        score: [Int]? = nil,
        notes: String? = nil,
        location: String? = nil
    ) {
        // First, fetch the existing game
        COLLECTION_GAMES.document(id).getDocument { (document, error) in
            guard let document = document,
                  var game = try? document.data(as: GameModel.self) else {
                print("Error fetching game to update")
                return
            }
            
            // Update fields if provided
            game.gameName = gameName ?? game.gameName
            game.size = size ?? game.size
            game.score = score ?? game.score
            game.notes = notes ?? game.notes
            game.location = location ?? game.location
            
            do {
                try COLLECTION_GAMES.document(id).setData(from: game)
            } catch {
                print("Error updating game: \(error.localizedDescription)")
            }
        }
    }
    
    // Delete a game by its ID
    func deleteGame(id: String) {
        COLLECTION_GAMES.document(id).delete { error in
            if let error = error {
                print("Error deleting game: \(error.localizedDescription)")
            }
        }
    }
    
    // Fetch a specific game by ID
    func fetchGame(by id: String, completion: @escaping (GameModel?) -> Void) {
        COLLECTION_GAMES.document(id).getDocument { (document, error) in
            if let error = error {
                print("Error fetching game: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            let game = try? document?.data(as: GameModel.self)
            completion(game)
        }
    }
    
    // Filter games by some info
    func filterGames(userId: String, minScore: Int? = nil, location: String? = nil) {
        var query: Query = COLLECTION_GAMES.whereField("userId", isEqualTo: userId)
        
        if let minScore = minScore {
            query = query.whereField("score", isGreaterThanOrEqualTo: minScore)
        }
        
        if let location = location {
            query = query.whereField("location", isEqualTo: location)
        }
        
        query.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error filtering games: \(error.localizedDescription)")
                return
            }
            
            self.games = querySnapshot?.documents.compactMap { document in
                try? document.data(as: GameModel.self)
            } ?? []
        }
    }}
