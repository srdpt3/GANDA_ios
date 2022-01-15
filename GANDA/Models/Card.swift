//
//  Card.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/31/21.
//
import SwiftUI

struct Card: Identifiable {
    
    var id = UUID().uuidString
    var image : String
//    var cardColor: Color
    var date: String = ""
    var title: String
}
