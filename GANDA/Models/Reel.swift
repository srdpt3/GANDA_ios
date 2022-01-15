//
//  Reel.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/11/22.
//


import SwiftUI
import AVKit

struct Reel: Identifiable {

    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
