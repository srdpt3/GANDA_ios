//
//  Flag.swift
//  GANDA
//
//  Created by Dustin yang on 1/25/22.
//


import SwiftUI


import Foundation
struct Flag:  Encodable, Decodable ,Identifiable, Hashable{
    var id = UUID()
    var vote : ActiveVote
    var email: String
    var username: String
    var reason: String
    var date: Double

    
    
//    init(vote: ActiveVote, email: String, imageLocation: String, username: String, reason: String ,reporter: String, date: Double) {
//
//
//        self.id = id
//        self.email = email
//        self.imageLocation = imageLocation
//        self.username = username
//        self.reason = reason
//        self.date = date
//        self.reporter = reporter
//
//    }
//    init(_dictionary: NSDictionary) {
//
//        id = _dictionary["id"] as! String
//        email = _dictionary["email"] as! String
//        imageLocation = _dictionary["imageLocation"] as! String
//        username = _dictionary["username"] as! String
//        reason = _dictionary["reason"] as! String
//        reporter = _dictionary["reporter"] as! String
//        date = _dictionary["date"] as! Double
//
//    }
}
