//
//  PostCardView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/1/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardView: View{
    
    var post: ActiveVote
    @State var isAnimating : Bool = true
    var body: some View{
        
        
        if(self.post.imageLocation != ""){
            AnimatedImage(url: URL(string: post.imageLocation),isAnimating:$isAnimating)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }else{
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(GRADIENT_COLORS[GRADIENT_COLORS.count - 1])
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .shadow(color: Color.black.opacity(0.3), radius: 1, x: 1, y: 1)
                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
        }
        
            
            
     

        
      
        
//        AsyncImage(
//            url: URL(string: post.imageLocation),
//            content: { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .cornerRadius(10)
//            },
//            placeholder: {
//                ProgressView()
//            }
//        )
        
        //        Image(post.imageURL)
        //            .resizable()
        //            .aspectRatio(contentMode: .fill)
        //            .cornerRadius(10)
    }
}
