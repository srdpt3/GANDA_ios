//
//  Post.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/1/22.
//

import SwiftUI

struct Post: Identifiable,Hashable {
    var id = UUID().uuidString
    var imageURL: String
}
