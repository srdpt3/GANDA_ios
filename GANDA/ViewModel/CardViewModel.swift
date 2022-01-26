//
//  CardViewModel.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/30/21.
//

import SwiftUI

import Firebase
import FirebaseAuth

class CardViewModel: ObservableObject {
    
    // Store All the fetched Users here...
    // Since we're building UI so using sample Users here....
    @Published var activeCards = [ActiveVote]()
    @Published var myActiveCards = [ActiveVote]()
    
    @Published var isVoteLoading : Bool = false
    @Published var isReloading : Bool = false
    @Published var error: NSError?
    @Published var liked : Bool = false
    
    //    @Published var voted : Bool = false
    //    @Published var liked : Bool = false
    @Published var totalVoted : Int = 0
    @Published var totalSkipped : Int = 0
    @Published var totalFlagged: Int = 0
    @Published var votedCards = [String]()
    @Published var isLoading = false
    @Published var mainVoteCard = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [],numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0, itemType: "")

    let CARDLIMIT : Int = 5
    @Published var columns: Int = 3

    init(){
    }
    

    
    
    func checkLiked(postId : String,onSuccess: @escaping(_ result: Bool) -> Void){
        var result : Bool = false

        Ref.FIRESTORE_COLLECTION_LIKED_POSTID(userId: User.currentUser()!.id, postId: postId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                result = true
            } else {
                result  = false
            }
            onSuccess(result)
        }
       
    }
    
    func disLikePost(postId : String ,onSuccess: @escaping(_ result: Bool) -> Void) {
        var result : Bool = false
        Ref.FIRESTORE_COLLECTION_LIKED_POSTID(userId: User.currentUser()!.id, postId: postId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
                print("Removed sucessfully from liked : \(postId) ")
                result = false
                
                let batch = Ref.FIRESTORE_ROOT.batch()
                
                let voteRef = Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.document(postId)
                batch.updateData(["numLiked" : FieldValue.increment(Int64(-1))], forDocument: voteRef)
                        
                batch.commit() { err in
                    if let err = err {
                        print("Error writing batch \(err)")
                    } else {
                        print("Batch write succeeded.")
                        result = false
                        
                        
                    }
                    
                    onSuccess(result)
                }

                
                
            }
            
            
        }
      
        
    }
 
    
    func likePost(post: ActiveVote , onSuccess: @escaping(_ result: Bool) -> Void) {
        var result: Bool = false
        let batch = Ref.FIRESTORE_ROOT.batch()
        
        let currentUser = User.currentUser()!

        guard let userDict = try? currentUser.toDictionary() else {return}
        
//
        let id = post.id.uuidString
        let voteRef = Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.document(id)
        batch.updateData(["numLiked" : FieldValue.increment(Int64(1))], forDocument: voteRef)
        
        
        let likeRef = Ref.FIRESTORE_COLLECTION_LIKED_POSTID(userId: User.currentUser()!.id, postId: post.id.uuidString)
        batch.setData(userDict, forDocument: likeRef)
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
                result = true
                
                
            }
            
            onSuccess(result)

        }
        
    }
    
    
    func deletePost(postId : String ,onSuccess: @escaping(_ result: Bool) -> Void) {
        var result : Bool = false
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE_POSTID(postId: postId).getDocument{ document, err in
            if let doc = document, doc.exists {
                doc.reference.delete()
                result = true
            }
            
            onSuccess(result)
        }
        
        
    }
    
    
    
  
}
