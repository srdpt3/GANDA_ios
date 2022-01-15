//
//  ViewExtension.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/3/22.
//


import Foundation
import SwiftUI



// Extending View to get SCreen Bounds...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
    
    // Retreiving RootView COntroller...
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}
