//
//  ChartViewModel.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/11/22.
//

import SwiftUI
import Foundation

class ChartViewModel: ObservableObject {
    @Published var isLoading = false
    //    @Published var voteData: Vote?
    @Published var error: NSError?
    
    //    @Published var voteData : [Int]?
//    @Published var someOneVoted = [Activity]()
    
    //    var listener: ListenerRegistration!
    @Published var activeVote : ActiveVote?
    
//    func loadSomeoneVoted() {
//        isLoading = true
//        self.someOneVoted.removeAll()
//
//
//
//        Ref.FIRESTORE_COLLECTION_WHO_VOTED.document(User.currentUser()!.id).collection("voted").order(by: "date", descending: true).limit(to: 6).addSnapshotListener({ (querySnapshot, error) in
//            guard let snapshot = querySnapshot else {
//                return
//            }
//
//            snapshot.documentChanges.forEach { (documentChange) in
//
//                switch documentChange.type {
//                case .added:
//                    //                    var activityArray = [Activity]()
//                    print("type: added")
//                    let dict = documentChange.document.data()
//                    guard let decoderActivity = try? Activity.init(fromDictionary: dict) else {return}
//
//                    //
//                    if(self.someOneVoted.count == 1 && self.someOneVoted[0].userAvatar == ""){
//                        self.someOneVoted.removeAll()
//                    }
//
//                    self.someOneVoted.append(decoderActivity)
//                case .modified:
//                    print("type: modified")
//                case .removed:
////                    self.someOneVoted.removeAll()
//
//                    print("type: removed")
//                }
//
//            }
//
//
//
//            if (self.someOneVoted.isEmpty){
//                let activity = Activity(activityId: "", type: "", username: "", userId: "", userAvatar: "", message: "", date: 0, read: true, age: "", location: "" ,occupation: "", description: "")
//                self.someOneVoted.append(activity)
//            }
//
//        })
//
//
//    }
    
    func loadChartData(postId: String, onSuccess: @escaping(_ data: ActiveVote) -> Void) {
        isLoading = true
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE_POSTID(postId: postId).addSnapshotListener { (querySnapshot, error) in
            guard let document = querySnapshot else {
                print("No documents")
                return
            }
            
            var data : ActiveVote?
            
            if(document.documentID == postId && document.data() != nil){
                let _dictionary = document.data()
              

//                let attr1 = _dictionary["attr1"] as! Int
//                let attr2 = _dictionary["attr2"] as! Int
//                let attr3 = _dictionary["attr3"] as! Int
//                let attr4 = _dictionary["attr4"] as! Int
//                let attr5 = _dictionary["attr5"] as! Int
//                let title = _dictionary["description"] as! String
//                let tags = _dictionary["tags"] as! [Tag]
//
//                let attrNames = _dictionary["attrNames"] as! [String]
//
//                let numVote = _dictionary["numVote"] as! Int
//                let userId = _dictionary["userId"] as! String
//                let username = _dictionary["username"] as! String
//                let email = _dictionary["email"] as! String
//
//                let createdDate = _dictionary["createdDate"] as! Double
//                let lastModifiedDate = _dictionary["lastModifiedDate"] as! Double
//                let imageLocation = _dictionary["imageLocation"] as! String
//
//                data = ActiveVote.init(attr1: attr1, attr2: attr1, attr3: attr3, attr4: attr1, attr5: attr5, attrNames: attrNames, tags: tags,  numVote: numVote, createdDate: createdDate, lastModifiedDate: lastModifiedDate, userId: userId, email: email, imageLocation: imageLocation, username: username, sex: "", location: "", description: title)
//
//                let dict = document.data()!
                guard let decoderVote = try? ActiveVote.init(fromDictionary: _dictionary) else {return}
                data = decoderVote
                
                
            }
//            else{
//                data = Vote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], numVote: 0, createdDate: 0, lastModifiedDate: 0, imageLocation : User.currentUser()!.profileImageUrl)
//            }
            self.isLoading = false
            
            onSuccess(data!)
            
            
        }
        
    }
    
    
    
}
