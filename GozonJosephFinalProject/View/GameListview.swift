//
//  GameListview.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/11/24.
//

import Foundation
import SwiftUI

struct GameListView: View {
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(userViewModel.games) { game in
                    GameCellView(game: game)
                }
                .onDelete(perform: deleteGame)
            }
            .refreshable {
                userViewModel.fetchGames()
            }
            .navigationTitle("Games")
        }
    }
    
    private func deleteGame(at offsets: IndexSet) {
        offsets.map { userViewModel.games[$0] }.forEach { game in
            guard let gameId = game.id else { return }
            COLLECTION_GAMES.document(gameId).delete() { err in
              if let err = err {
                print("Error removing document: \(err)")
              } else {
                print("Document successfully removed!")
              }
            }
          }
        
    }
}
