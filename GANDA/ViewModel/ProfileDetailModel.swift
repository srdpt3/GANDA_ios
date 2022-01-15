//
//  ProfileDetailModel.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/12/22.
//

import SwiftUI

class ProfileDetailModel: ObservableObject {

    @Published var showProfile = false
    
    // Storing The Selected profile...
    @Published var selectedProfile : Profile!
    
    // To Show Big Image...
    @Published var showEnlargedImage = false
    
    // Drag to close...
    @Published var offset: CGFloat = 0
    
    @Published var token : String = ""
}
