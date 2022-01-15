//
//  VoteViewModel.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/5/22.
//


import SwiftUI
import Firebase

class VoteViewModel: ObservableObject {
    @Published var isSucess = false
    @Published var error: NSError?
    @Published var voted : Bool = false
    @Published var liked : Bool = false
    @Published var totalVoted : Int = 0
    @Published var totalSkipped : Int = 0
    @Published var totalFlagged: Int = 0
    
    @Published var votedCards = [String]()
    @Published var isLoading = false
    var updatedValueDict = ["attr1":0 , "attr2":0, "attr3":0]
    var buttonTitle : [String] = ["없음", "없음","없음"]
    
    @Published var someOneVoted = [ActiveVote]()

    init(){
        checkVoted()
    }
    
    
//    func loadSomeoneVoted(postId: String) {
//        isLoading = true
//        self.someOneVoted.removeAll()
//        
//        
//        Ref.FIRESTORE_COLLECTION_WHO_VOTED.document(postId).collection("voted").order(by: "date", descending: true).limit(to: 5).addSnapshotListener({ (querySnapshot, error) in
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
////                    guard let decoderActivity = try? Activity.init(fromDictionary: dict) else {return}
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
//    
    
    
    
    
    func persist(votePost:  ActiveVote, buttonPressed:[Bool]) {
        
        
        var post :ActiveVote = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [],tags: [],  numVote: 0,  createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: TOKEN)
        post  = votePost
        //batch writing. vote multiple entries
        let batch = Ref.FIRESTORE_ROOT.batch()
        let currentUser = User.currentUser()!
        //Update User Point
        //                let updated_point = currentUser.point_avail + POINT_USE
//        let user = User.init(id: currentUser.id, email: currentUser.email, profileImageUrl: currentUser.profileImageUrl, username: currentUser.username, age: currentUser.age, sex: currentUser.sex, createdDate:  currentUser.createdDate, point_avail: updated_point)
//        guard let userDict = try? user.toDictionary() else {return}
//
//
////        saveUserLocally(mUserDictionary: userDict as NSDictionary)
//
//
//        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: User.currentUser()!.id)
//        batch.updateData(["point_avail" : updated_point], forDocument: firestoreUserId)
//
        let id = votePost.id.uuidString
        let voteRef = Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.document(id)
        var key = ""
        for (index, button) in buttonPressed.enumerated() {
            
            if (button){
                if(index == 0) {
                    post.attr1 = 1
                    key = "attr1"
                }else if (index == 1){
                    post.attr2 = 1
                    key = "attr2"
                }else{
                    post.attr3 = 1
                    key = "attr3"
                }
                //                let key = (index == 0 ? "attr1" :  (index == 1 ? "attr2" : "attr3"))
                //                print("\(index + 1). \(buttonTitle[index])  \(key)")
                //                updatedValueDict[key] = 1
                
            }
        }
        batch.updateData([key : FieldValue.increment(Int64(1))], forDocument: voteRef)
        batch.updateData([VOTE_NUMBER : FieldValue.increment(Int64(1))], forDocument: voteRef)
        //                let myVote = Vote(attr1: 0, attr2 : 0 , attr3 : 1 , attr4: 2, attr5: 0,attrNames:buttonTitle)
        guard let dict = try? post.toDictionary() else {return}
        let myVoteRef = Ref.FIRESTORE_COLLECTION_MYVOTE_USERID(postId:id)
        
        //        let myVote = MyVote(userId: id, myVotes: updatedValueDict, attrNames: buttonTitle, voteDate: Date().timeIntervalSince1970, comment: "")
        //        guard let dict = try? myVote.toDictionary() else {return}
        batch.setData(dict, forDocument: myVoteRef)
        
        
        
        
//
        //                let someoneVoteObject = Activity(activityId: User.currentUser()!.id, type: "voted", username: User.currentUser()!.username, userId: User.currentUser()!.id, userAvatar: User.currentUser()!.profileImageUrl, message: "", date: Date().timeIntervalSince1970, read: false, age: User.currentUserProfile()!.age, location: User.currentUserProfile()!.location,occupation: User.currentUserProfile()!.occupation, description: User.currentUserProfile()!.description)
        
        
        guard let someOneVotedDict = try? currentUser.toDictionary() else { return }
        let someOneVoteRef  = Ref.FIRESTORE_COLLECTION_WHO_VOTED_USERID(postId: id)
        batch.setData(someOneVotedDict, forDocument: someOneVoteRef)
        
        
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
                self.isSucess = true
                
                
            }
        }
        
        
        
    }
    
    func checkVoted(){
        self.isSucess = false
        
        var result : Bool = false
        
        Ref.FIRESTORE_COLLECTION_MYVOTE.document(User.currentUser()!.id).collection("voted").order(by: "lastModifiedDate", descending: true).addSnapshotListener ({ (snapshot, error) in
            
            self.votedCards.removeAll()
            
            snapshot!.documentChanges.forEach { (documentChange) in
                
                switch documentChange.type {
                case .added:
                    //                    var activityArray = [Activity]()
                    print("type: added")
                    //                    self.send()
                    
                    let dict = documentChange.document.data()
                    guard let decoderActivity = try? ActiveVote.init(fromDictionary: dict) else {return}
                    self.votedCards.append(decoderActivity.id.uuidString)
                    print(decoderActivity.id.uuidString)
//                    guard let decoderActivity = try? ActiveVote.init(fromDictionary: dict) else {return}
//                    self.votedCards.append(decoderActivity)
                    //
                    //                    self.readActivity.append(decoderActivity.activityId)
                    //                    self.activityArray.append(decoderActivity)
                case .modified:
                    print("type: modified")
                    
                case .removed:
                    print("type: removed")
                }
                
                
            }
        })
    }
    
 
    
    
}

