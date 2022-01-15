//
//  ActiveVote.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/3/22.
//

import SwiftUI

import Foundation
struct ActiveVote: Encodable, Decodable, Identifiable,Hashable{
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
    
    
}
