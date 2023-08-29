//
//  ContentView.swift
//  memorize
//
//  Created by Alan Zhang on 2023/8/20.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️","🧙", "🙀", "👹", "😱", "☠️","🍭"]
    let minimalCards = 1
    @State var cardCount = 4
    var body: some View {
        VStack {
            CardsView(cardCount: cardCount, emojis: emojis)
            Spacer()
            cardCountAdjusters
        }
        .padding()
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            //cardRemover
            cardCountAdjuster(by:-1, symbol: "rectangle.stack.fill.badge.minus")
            Spacer()
            cardCountAdjuster(by:1, symbol: "rectangle.stack.fill.badge.plus")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            let currentCount = cardCount + offset
            if !((currentCount < minimalCards) || (currentCount > (emojis.count - 1))) {
                cardCount += offset
            }
        }) {
            Image(systemName: symbol)
        }
    }
}

struct CardsView: View {
    var cardCount:Int
    var emojis: [String]
    let gridColumns = [GridItem(), GridItem(), GridItem(), GridItem()]

    var body: some View{
        LazyVGrid (columns: gridColumns){
            ForEach (0..<cardCount, id: \.self) { index in
                CardView(symbol: emojis[index])
            }
        }
    }
}
struct CardView: View {
    let symbol: String
    @State var isFaceUp = false
    @State var opacity = 0.0
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
            }else{
                base.fill()
            }
            Text(symbol)
                .imageScale(Image.Scale.large)
                .opacity(opacity)
        }
        .onTapGesture {
            isFaceUp.toggle()
            opacity = (isFaceUp ? 1.0 : 0.0)
        }
        .imageScale(.large)
        .font(.largeTitle)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
