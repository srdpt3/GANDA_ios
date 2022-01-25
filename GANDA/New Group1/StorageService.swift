//
//  StorageService.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/3/22.
//

import SwiftUI

import Foundation
import Firebase

class StorageService {
    

    static func saveVotePicture(myVote:Vote, userId: String, imageData: Data, metadata: StorageMetadata, storageAvatarRef: StorageReference, onSuccess: @escaping(_ success: Bool ) -> Void){
        
        var result : Bool = false
        storageAvatarRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            storageAvatarRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    //                    guard let dict = try? myVote.toDictionary() else {return}
                    
                    
//                    let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: UUID().uuidString)
//
//                    firestoreUserId.updateData([
//                        "profileImageUrl": metaImageUrl
//                    ]) { err in
//                        if let err = err {
//                            print("Error updating document: \(err)")
//                        } else {
//                            print("Document successfully updated")
//                        }
//                    }
                    
//
//
//
//                    let user = User.currentUser()!
//                    let userProfile = User.currentUserProfile()!
//
//                    let user_update = User.init(id: user.id, email: user.email, profileImageUrl: metaImageUrl, username: user.username, age: user.age, sex: user.sex, createdDate: user.createdDate, point_avail: user.point_avail)
//                    guard let dict = try? user_update.toDictionary() else {return}
//                    saveUserLocally(mUserDictionary: dict as NSDictionary)
//
//
                    let voteId = UUID()
//                    //                    let user =  User(id: userId, email: "test@gmail.com", profileImageUrl:  metaImageUrl, username: "test", age: "30", sex:"male",    swipe:0, degree: 0)
                    let data =  ActiveVote.init(id: voteId, attr1: myVote.attr1, attr2: myVote.attr1, attr3: myVote.attr1, attr4: myVote.attr4, attr5: myVote.attr5, attrNames: myVote.attrNames, tags: myVote.tags,  numVote: myVote.numVote, createdDate: myVote.createdDate, lastModifiedDate: myVote.lastModifiedDate, userId: User.currentUser()!.id, email: User.currentUser()!.email, imageLocation: metaImageUrl, username: User.currentUser()!.username, sex: "", location: "", description: myVote.title, token: TOKEN, numLiked: 0, itemType: "")
                    guard let finalDict = try? data.toDictionary() else {return}


                    //                    let finalDict = dict.merging(userDict) { (_, new) in new }

                    Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE_POSTID(postId:voteId.uuidString).setData(finalDict) { (error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            return

                        }
                        
                        result = true
                        onSuccess(result)
                    }
  
                }
            }
            
        }
    }
    
    static func saveUser(userId: String, username: String, email: String, age: String, storageAvatarRef: StorageReference, gender: String,  location: String, occupation:String,  longitude: String, latitude: String, description: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        let batch = Ref.FIRESTORE_ROOT.batch()
        
        let user = User.init(id: userId, email: email, profileImageUrl: "", username: username, sex: gender, createdDate:  Date().timeIntervalSince1970, point_avail: INITIAL_POINT, token: TOKEN)
        
        guard let dict = try? user.toDictionary() else {return}
//        saveUserLocally(mUserDictionary: dict as NSDictionary)
        
//        let userProfile = UserProfile.init(id: userId, email: email, profileImageUrl: "", username: username, sex: gender, createdDate:  Date().timeIntervalSince1970, point_avail: INITIAL_POINT, location: location, occupation: occupation,  longitude: longitude, latitude: latitude, description: description)
//        guard let dict2 = try? userProfile.toDictionary() else {return}
//
//
//        saveUserLocationLocally(mUserDictionary: dict2 as NSDictionary)

        
        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
            changeRequest.displayName = username
            changeRequest.commitChanges { (error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
            }
        }
        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
        batch.setData(dict, forDocument: firestoreUserId)
        
//        let userLocationRef = Ref.FIRESTORE_DOCUMENT_USER_LOCATION(userId: userId)
//        batch.setData(dict2, forDocument: userLocationRef)
//
        
        
//        let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY_USERID(userId: userId).collection("activity").document().documentID
//        let activityObject = UserNotification(activityId: activityId, type: "intro", username: User.currentUser()!.username, userId: User.currentUser()!.id, userAvatar: "", message: "", date: Date().timeIntervalSince1970, read: true,  location: User.currentUserProfile()!.location)
//        guard let activityDict = try? activityObject.toDictionary() else { return }
//
//
//        let activityRef  = Ref.FIRESTORE_COLLECTION_ACTIVITY_USERID(userId:userId).collection("activity").document(activityId)
//        batch.setData(activityDict, forDocument: activityRef)
        
        
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch persistMatching write succeeded.")
                
            }
        }
        
    }
    
    
    static func saveAvatar(userId: String, username: String, email: String, imageData: Data, metadata: StorageMetadata, storageAvatarRef: StorageReference, gender: String,  onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        storageAvatarRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageAvatarRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    
                    let batch = Ref.FIRESTORE_ROOT.batch()
                    
                    let user = User.init(id: userId, email: email, profileImageUrl: metaImageUrl, username: username, sex: gender, createdDate:  Date().timeIntervalSince1970, point_avail: INITIAL_POINT, token: TOKEN)
                    
                    guard let dict = try? user.toDictionary() else {return}
//                    User.saveUserLocally(mUserDictionary: dict as NSDictionary)
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges { (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
                    
                    batch.setData(dict, forDocument: firestoreUserId)
                    
                    
//                    let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY_USERID(userId: userId).collection("activity").document().documentID
//                    let activityObject = UserNotification(activityId: activityId, type: "intro", username: User.currentUser()!.username, userId: User.currentUser()!.id, userAvatar: metaImageUrl, message: "", date: Date().timeIntervalSince1970, read: false,  location: User.currentUserProfile()!.location)
//                    guard let activityDict = try? activityObject.toDictionary() else { return }
//                    
//                    
//                    let activityRef  = Ref.FIRESTORE_COLLECTION_ACTIVITY_USERID(userId:userId).collection("activity").document(activityId)
//                    batch.setData(activityDict, forDocument: activityRef)
//                    
                    //                    let userInfor = ["username": username, "email": email, "profileImageUrl": metaImageUrl]
                    //                    let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: "", keywords: username.splitStringToArray())
                    //                    let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: "")
                    
                    
                    
                    //
                    //                        guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
                    //                        print(decoderUser.username)
                    
                    //                    firestoreUserId.setData() { (error) in
                    //                        if error != nil {
                    //                            onError(error!.localizedDescription)
                    //                            return
                    //                        }
                    //                        onSuccess(user)
                    //                    }
                    
                    batch.commit() { err in
                        if let err = err {
                            print("Error writing batch \(err)")
                        } else {
                            print("Batch persistMatching write succeeded.")
                            onSuccess(user)
                            
                            
                            //
                            //                    LottieView(filename: "fireworks")
                            //                                   .frame(width: 300, height: 300)
                            
                            
                            
                        }
                    }
                    
                }
            }
            
        }
    }
}
