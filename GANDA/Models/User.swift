//
//  User.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/30/21.
//

import Foundation
import FirebaseAuth

struct User: Encodable, Decodable ,Identifiable{
    //    var id: ObjectIdentifier
    
    var id : String
    var email: String
    var profileImageUrl: String
    var username: String
    var sex: String
    var createdDate : Double
    var point_avail : Int
    var token : String
    
    
    init(id: String, email: String, profileImageUrl: String, username: String, sex:String, createdDate : Double, point_avail: Int, token : String) {
        self.id = id
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.username = username
        self.sex = sex
        self.createdDate = createdDate
        self.point_avail = point_avail
        self.token = token
    }
    init(_dictionary: NSDictionary) {
        id = _dictionary["id"] as! String
        email = _dictionary["email"] as! String
        profileImageUrl = _dictionary["profileImageUrl"] as! String
        username = _dictionary["username"] as! String
        sex = _dictionary["sex"] as! String
        createdDate = _dictionary["createdDate"] as! Double
        point_avail = _dictionary["point_avail"] as! Int
        token = _dictionary["token"] as! String

    }
    
    
    static func currentUser() -> User? {
        
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.object(forKey: "currentUser_test") {
                //                print(User.init(_dictionary: dictionary as! NSDictionary))
                return User.init(_dictionary: dictionary as! NSDictionary)
            }
        }
        //        return User(id: "63gIkD569ywBbqfuqEx4", email: "test@gmail.com", profileImageUrl: "https://www.thesprucepets.com/thmb/mERLXPcXz4U9G702HlsORXJqZrU=/4231x2380/smart/filters:no_upscale()/adorable-white-pomeranian-puppy-spitz-921029690-5c8be25d46e0fb000172effe.jpg", username: "test", age: "29", sex: "male", createdDate: 0, point_avail: 0)
        return nil
    }
    
    
//    static func saveUserLocally(mUserDictionary: NSDictionary) {
//        print("Saved Locally")
//        UserDefaults.standard.set(mUserDictionary, forKey: "currentUser")
//        UserDefaults.standard.synchronize()
//    }

    
    
    //    static func currentUserProfile() -> UserProfile? {
    //        
    //        if Auth.auth().currentUser != nil {
    //            if let dictionary = UserDefaults.standard.object(forKey: "currentUserProfile") {
    //                return UserProfile.init(_dictionary: dictionary as! NSDictionary)
    //
    //            }
    //
    //
    //        }
    //        return nil
    //
    //    }
    
    
}


struct AppleUser: Encodable, Decodable ,Identifiable{
    //    var id: ObjectIdentifier
    
    var id : String
    var email: String
    var username: String
  
    
    
    init(id: String, email: String,  username: String) {
        self.id = id
        self.email = email
        self.username = username
   
    }
    init(_dictionary: NSDictionary) {
        id = _dictionary["id"] as! String
        email = _dictionary["email"] as! String
        username = _dictionary["username"] as! String
    }
    
    
    static func appleUser() -> AppleUser? {
        
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.object(forKey: "apple_user_test") {
                //                print(User.init(_dictionary: dictionary as! NSDictionary))
                return AppleUser.init(_dictionary: dictionary as! NSDictionary)
            }
        }
        //        return User(id: "63gIkD569ywBbqfuqEx4", email: "test@gmail.com", profileImageUrl: "https://www.thesprucepets.com/thmb/mERLXPcXz4U9G702HlsORXJqZrU=/4231x2380/smart/filters:no_upscale()/adorable-white-pomeranian-puppy-spitz-921029690-5c8be25d46e0fb000172effe.jpg", username: "test", age: "29", sex: "male", createdDate: 0, point_avail: 0)
        return nil
    }
}
