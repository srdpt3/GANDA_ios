//
//  Vote.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/3/22.
//


import Foundation
struct Vote: Encodable, Decodable, Identifiable,Hashable{
    var id = UUID()
    var attr1 : Int
    var attr2: Int
    var attr3: Int
    var attr4: Int
    var attr5: Int
    var title: String
    var tags: [Tag]
    var attrNames: [String]
    var numVote: Int
    var createdDate: Double
    var lastModifiedDate: Double
    var imageLocation: String
    
   
}

