//
//  ActiveVote.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/3/22.
//

import SwiftUI

import Foundation
struct ActiveVote: Codable, Identifiable,Hashable{
    var id = UUID()
    var attr1 : Int
    var attr2: Int
    var attr3: Int
    var attr4: Int
    var attr5: Int
    var attrNames: [String]
    var tags: [Tag]
    var numVote: Int
    var createdDate: Double
    var lastModifiedDate: Double
    var userId : String
    var email: String
    var imageLocation: String
    var username: String
    var sex: String
    var location: String
    var description: String
    var token : String
    var numLiked: Int
    var itemType: String


    
    
}


// Product Types...
enum ItemType: String,CaseIterable {
    case dailyLook = "데일리 룩"
    case datingLook = "데이팅 룩"
    case hotItem = "핫템"
    case shoppingItem = "쇼핑템"
}




