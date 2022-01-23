//
//  Layout1.swift
//  GANDA
//
//  Created by Dustin yang on 1/22/22.
//


import SwiftUI
import SDWebImageSwiftUI

// Width...
// Padding = 30
var width = UIScreen.main.bounds.width - 30
struct Layout1: View {
    @EnvironmentObject var observer : Observer

    var cards: [ActiveVote]
    @Binding var selected : ActiveVote
    @Binding var showDetailScreen : Bool
    @Binding var showDetailView : Bool
//    @State var isAnimating : Bool = true

//    @Namespace var animation
    let animation: Namespace.ID

    
    var body: some View {
        if(!cards.isEmpty){
            HStack(spacing: 4){
                
                AnimatedImage(url: URL(string: cards[0].imageLocation))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (width - (width / 3) + 4), height: 250)
                    .cornerRadius(4)
                    .matchedGeometryEffect(id: cards[0].id, in: animation)
                    .onTapGesture {
                        withAnimation(.spring()){
                            
                            if cards[0].imageLocation != "" {
                                //                                                          self.voteBarData.removeAll()
                                //                                                          self.voteData.removeAll()
                                 self.selected = cards[0]
                                let postID = self.selected.id.uuidString
                                
                                print(TOKEN)
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                                    loadChartData(postId: postID)
                                    self.observer.checkLiked(postId: postID)
                                }
                                showDetailScreen.toggle()
                                showDetailView.toggle()
                                
                            }
                            
                        }
                    }.animation(.easeInOut, value: cards[0].id)

    //                .modifier(ContextModifier(card: cards[0]))
                
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    
    }
}

struct Layout1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
