//
//  ContentView.swift
//  memorize
//
//  Created by Alan Zhang on 2023/8/20.
//

import SwiftUI

struct ContentView: View {
    let emojis_themes: [[String]] = [
        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"],
        ["🐛", "🦋", "🐌", "🐞", "🐜", "🪰", "🪲", "🪳", "🦟", "🦗", "🦖", "🐙"],
        ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
    ]
    let minimalCards = 1
    @State var cardCount = 4
    @State var theme = 0
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            Spacer()
            CardsView(cardCount: cardCount, emojis: emojis_themes[theme])
            Spacer()
            themeAdjusters
        }
        .padding()
        .foregroundColor(.orange)
    }
    
    var themeAdjusters: some View {
        HStack {
            themeAdjuster(themeID: 0)
            Spacer()
            themeAdjuster(themeID: 1)
            Spacer()
            themeAdjuster(themeID: 2)
        }
    }
    
    func themeAdjuster(themeID: Int) -> some View {
        Button("Theme" + String(themeID), action: {
            theme = themeID
        })
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
