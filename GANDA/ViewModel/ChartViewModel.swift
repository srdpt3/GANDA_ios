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
    
//
    
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

//                let dict = document.data()!
                guard let decoderVote = try? ActiveVote.init(fromDictionary: _dictionary) else {return}
                data = decoderVote
                
                
            }
//            else{
//                data = Vote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], numVote: 0, createdDate: 0, lastModifiedDate: 0, imageLocation : User.currentUser()!.profileImageUrl)
//            }
            self.isLoading = false
            if(data != nil){
                onSuccess(data!)

            }
            
            
        }
        
    }
    
    
    
}
