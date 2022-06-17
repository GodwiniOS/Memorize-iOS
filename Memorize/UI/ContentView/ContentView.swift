//
//  ContentView.swift
//  Memorize
//
//  Created by Godwin A on 9/6/20.
//  Copyright © 2020 Godwin A. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        VStack {
            if viewModel.cards.allSatisfy({ $0.isMatched }) {
                Text("🥳 Congratulations 🥳")
                    .font(.largeTitle)
            } else {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear) {
                            try? Result { viewModel.choose(card: card) }
                                .get()
                        }
                    }
                    .padding()
                }
            }
            Button("Start a New Game") {
                withAnimation(.linear) {
                    try? Result { viewModel.newGame() }
                        .get()
                }
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    private enum Constant {
        static let flipAnimationDuration: Double = 0.75
    }
    var card: GameModel<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill()
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 84))
            } else if !card.isMatched {
                RoundedRectangle(cornerRadius: 10)
                    .fill()
            }
        }
        .animation(Animation.linear.delay(Constant.flipAnimationDuration / Double(card.isFaceUp ? 2 : 4)))
        .rotation3DEffect(.degrees(card.isFaceUp ? 0 : 180), axis: (0, 1, 0))
        .animation(Animation.linear(duration: Constant.flipAnimationDuration))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
