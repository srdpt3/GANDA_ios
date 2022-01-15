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
    
    
    let CARDLIMIT : Int = 5
    
    init(){
        getAllCard()
       getMyCards()
        
    }
    func getAllCard(){
        self.isReloading = true
        //        let whereField = User.currentUser()!.sex == "female" ? "male" : "female"
        //        let lesserGeopoint = GeoPoint(latitude: 0.5, longitude: 1)
        
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.limit(to: CARD_LIMIT_TO_QUERY).getDocuments { (snap, err) in
            self.activeCards.removeAll()
            
            if err != nil{
                print((err?.localizedDescription)!)
                self.error = (err! as NSError)
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                if(id != Auth.auth().currentUser?.uid){
                    
                    let dict = i.data()
                    guard let decoderPost = try? ActiveVote.init(fromDictionary: dict) else {return}
                    self.activeCards.append(decoderPost)
                }
                
            }
            self.isReloading = false
            
            while (self.activeCards.count < 15){
                
                let dummyCard = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [], numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "")
                self.activeCards.append(dummyCard)
                
                
                print("self.activeCards.count \(self.activeCards.count)")

            }
            

            
            
            print("self.activeCards.count \(self.activeCards.count)")
            
     
        }
        
    }
    
    
    func getMyCards(){
//        self.isReloading = true
        //        let whereField = User.currentUser()!.sex == "female" ? "male" : "female"
        //        let lesserGeopoint = GeoPoint(latitude: 0.5, longitude: 1)
        
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.whereField("userId", isEqualTo: User.currentUser()!.id ).limit(to: MY_CARD_LIMIT_TO_QUERY).getDocuments { [self] (snap, err) in
            self.myActiveCards.removeAll()
            
            if err != nil{
                print((err?.localizedDescription)!)
                self.error = (err! as NSError)
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                
                let dict = i.data()
                guard let decoderPost = try? ActiveVote.init(fromDictionary: dict) else {return}
                self.myActiveCards.append(decoderPost)
                
                
            }
//            self.isReloading = false
            
            while (self.myActiveCards.count < MY_CARD_LIMIT_TO_QUERY){
                
                let dummyCard = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [], numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "")
                self.myActiveCards.append(dummyCard)
                
                
//                print("self.activeCards.count \(self.activeCards.count)")

            }
            

            self.myActiveCards = self.myActiveCards.sorted(by: { $0.createdDate > $1.createdDate })
            
            print("self.myActiveCards.count \(self.myActiveCards.count)")
            
     
        }
        
    }
    
}
