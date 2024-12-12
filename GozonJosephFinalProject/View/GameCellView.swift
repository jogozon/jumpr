//
//  GameCellView.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/11/24.
//

import Foundation
import SwiftUI

struct GameCellView: View {
    var game: GameModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(game.gameName)
                    .font(.headline)
                Text("Your Team: \(game.score?[0] ?? 0) - Opponent Team: \(game.score?[1] ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(game.createdDate ?? Date(), style: .date)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
