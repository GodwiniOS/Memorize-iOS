//
//  ContentViewModel.swift
//  Memorize
//
//  Created by Godwin A on 9/6/20.
//  Copyright © 2020 Godwin A. All rights reserved.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    enum Constant {
        static let minimumPairs = 3
    }
    
    @Published private var model: GameModel<String> = createGame()
        
    static func createGame() -> GameModel<String> {
        let emojis = ["👻", "🎃", "🕷", "💀", "👽"]
        return GameModel(numberOfPairsOfCards: Int.random(in: Constant.minimumPairs...emojis.count)) { emojis[$0] }
    }
    
    // MARK: - Accessors
    
    var cards: [GameModel<String>.Card] { model.cards }
    
    // MARK: - Intents
    
    func choose(card: GameModel<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = Self.createGame()
    }
}
