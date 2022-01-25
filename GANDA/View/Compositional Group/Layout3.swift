//
//  Layout3.swift
//  GANDA
//
//  Created by Dustin yang on 1/22/22.
//


import SwiftUI
import SDWebImageSwiftUI

struct Layout3: View {
    var cards: [ActiveVote]
    var body: some View {
        if(!cards.isEmpty){
            HStack(spacing: 4){
                
                VStack(spacing: 4){
                    
                    // 123+123+4 = 250
                    if cards.count >= 2{
                        
                        AnimatedImage(url: URL(string: cards[1].imageLocation))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: ((width / 3)), height: 123)
                            .cornerRadius(4)
    //                        .modifier(ContextModifier(card: cards[1]))
                    }
                    
                    if cards.count == 3{
                        
                        AnimatedImage(url: URL(string: cards[2].imageLocation))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: ((width / 3)), height: 123)
                            .cornerRadius(4)
    //                        .modifier(ContextModifier(card: cards[2]))
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                AnimatedImage(url: URL(string: cards[0].imageLocation))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (width - (width / 3) + 4), height: 250)
                    .cornerRadius(4)
    //                .modifier(ContextModifier(card: cards[0]))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    
    }
}

struct Layout3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
