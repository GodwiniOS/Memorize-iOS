//
//  GameModel.swift
//  Memorize
//
//  Created by Godwin A on 9/6/20.
//  Copyright © 2020 Godwin A. All rights reserved.
//

import Foundation

struct GameModel<CardContent: Equatable> {
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
    private(set) var cards: [Card]
    private(set) var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.filter({ $0.isFaceUp }).count == 1 ? cards.firstIndex(where: { $0.isFaceUp }) : nil }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // MARK: - Init
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        cards.shuffle()
    }
    
    // MARK: - Interface
    
    mutating func choose(card: Card) {
        guard
            let index = cards.firstIndex(where: { $0.id == card.id }),
            !cards[index].isFaceUp,
            !cards[index].isMatched else {
            return
        }
        if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
            if card.content == cards[potentialMatchIndex].content {
                cards[index].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            cards[index].isFaceUp = true
        } else {
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
}
