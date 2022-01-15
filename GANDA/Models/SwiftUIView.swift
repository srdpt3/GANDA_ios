//
//  SwiftUIView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/12/22.
//

import SwiftUI

struct Profile: Identifiable {
    var id = UUID().uuidString
    var userName: String
    var profile: String
    var lastMsg: String
    var time: String
}

let recents = [

    Profile(userName: "iJustine", profile: "post1", lastMsg: "Hi Kavsoft !!!", time: "10:25"),
    Profile(userName: "Kaviya", profile: "post2", lastMsg: "What's Up 🥳🥳🥳", time: "11:25"),
    Profile(userName: "Emily", profile: "post3", lastMsg: "Need to Record Doumentation", time: "10:25"),
    Profile(userName: "Julie", profile: "post4", lastMsg: "Simply Sitting", time: "10:25"),
    Profile(userName: "Steve", profile: "post5", lastMsg: "Lying :(((((", time: "10:25"),
    Profile(userName: "Jenna", profile: "post6", lastMsg: "No March Event🥲", time: "06:25"),
]
