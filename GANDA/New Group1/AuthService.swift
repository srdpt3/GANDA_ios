//
//  AuthService.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/4/22.
//

import SwiftUI
import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage


class AuthService {

    static func resetDefaults() {
        print("resetDefaults")
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

//    static func removeDefaults(entry: String) {
//        print("removeDefaults")
//        if(isKeyPresentInUserDefaults(key: entry)){
//            UserDefaults.standard.removeObject(forKey: entry)
//        }
//    }
   
}



func saveUserLocally(mUserDictionary: NSDictionary) {
    print("Saved Locally")
    UserDefaults.standard.set(mUserDictionary, forKey: "currentUser_test")
    UserDefaults.standard.synchronize()
}

