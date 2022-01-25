//
//  Layout2.swift
//  GANDA
//
//  Created by Dustin yang on 1/22/22.
//


import SwiftUI
import SDWebImageSwiftUI

struct Layout2: View {
    var cards: [ActiveVote]
    var body: some View {
        if(!cards.isEmpty){
            HStack(spacing: 4){
               
                AnimatedImage(url: URL(string: cards[0].imageLocation))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((width / 3)), height: 125)
                    .cornerRadius(4)
    //                .modifier(ContextModifier(card: cards[0]))
                

                if cards.count >= 2{
                    
                    AnimatedImage(url: URL(string: cards[1].imageLocation))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ((width / 3)), height: 125)
                        .cornerRadius(4)
    //                    .modifier(ContextModifier(card: cards[1]))
                }
                
                if cards.count == 3{
                    
                    AnimatedImage(url: URL(string: cards[2].imageLocation))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ((width / 3)), height: 125)
                        .cornerRadius(4)
    //                    .modifier(ContextModifier(card: cards[2]))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
   
    }
}

struct Layout2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
