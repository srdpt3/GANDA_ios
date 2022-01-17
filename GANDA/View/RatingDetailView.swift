//
//  RatingDetailView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/11/22.
//

import SwiftUI

struct RatingDetailView: View {
    
    //    var recipe: Recipe
    var card:  ActiveVote
    @Binding var numLiked : Int
    @Binding var numVote : Int

    var hideDetail : Bool = true

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(alignment: .center, spacing: 2) {
                Image(systemName: "person.2")
                Text(VOTENUM + (!hideDetail ? String(numVote) : "***"))
            }
            
            HStack(alignment: .center, spacing: 2) {
                Image(systemName: "suit.heart")
                Text(LIKENUM + (!hideDetail ? String(numLiked) : "***"))
            }
            HStack(alignment: .center, spacing: 2) {
                Image(systemName: "clock")
                Text(VOTE_TIMESTAMP + timeAgoSinceDate(Date(timeIntervalSince1970: self.card.createdDate ), currentDate: Date(), numericDates: true))
            }
//            HStack(alignment: .center, spacing: 2) {
//                Image(systemName: "mappin.circle")
//
//                Text(self.card.location)
//            }
//            HStack(alignment: .center, spacing: 2) {
//
//                Text(AGE +  String(self.card.age))
//
//            }
        }
        .font(.custom(FONT, size: CGFloat(14)))
        .foregroundColor(Color.gray)
    }
}

