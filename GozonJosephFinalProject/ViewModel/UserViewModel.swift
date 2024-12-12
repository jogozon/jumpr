//
//  UserViewModel.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/10/24.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    @Published var games = [GameModel]()
    
    // use the auth viewmodel to get around the self not initialized thing
    init(authVM: AuthViewModel) {
        if let user = authVM.currentUser {
            self.user = user
        }
        fetchGames()
    }
    
    
    // Fetch all games for a specific user -> use the uid of the usermodel
    func fetchGames() {
        var newGames = [GameModel]()
        COLLECTION_GAMES.getDocuments { (querySnapshot, error) in
            if let snapshotDocuments = querySnapshot?.documents {
                for document in snapshotDocuments {
                    do {
                        let game = try document.data(as: GameModel.self)
                        newGames.append(game)
                    } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                    }
                }
                self.games = newGames
            }
        }
    }
    
    // delete a game given an id
    func deleteGame(withId id: String, completion: @escaping (Error?) -> Void) {
        COLLECTION_GAMES.document(id).delete { error in
            completion(error)
        }
    }
}


