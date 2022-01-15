//
//  MediaFile.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/11/22.
//


import SwiftUI

// Sample Model And Reels Videos...
struct MediaFile: Identifiable{
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}

var MediaFileJSON = [
    
   MediaFile(url: "video1", title: "My OOTD Test"),
   MediaFile(url: "video2", title: "My OOTD Test"),
   MediaFile(url: "video3", title: "My OOTD Test"),
   MediaFile(url: "video4", title: "SMy OOTD Test"),
   MediaFile(url: "video7", title: "My OOTD Test"),
   MediaFile(url: "video6", title: "My OOTD Test"),
   
]
