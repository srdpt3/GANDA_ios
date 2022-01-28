//
//  Observer.swift
//  GANDA
//
//  Created by Dustin yang on 1/14/22.
//

import SwiftUI
import Firebase


class Observer: ObservableObject {
    
    @AppStorage("isLogged") var log_Status = false
    @Namespace var animation_card

    @Published var isSucess = false
    @Published var error: NSError?
    @Published var totalFlagged: Int = 0
    //    @Published var votedCards = [String]()
    @Published var isLoading = false
    var updatedValueDict = ["attr1":0 , "attr2":0, "attr3":0]
    var buttonTitle : [String] = ["없음", "없음","없음"]
    
    
    //    @Published var activeCards = [ActiveVote]()
    
    @Published var mainVoteData:[Double] = [0,0,0]
    @Published var mainVoteNum : Int = 0
    @Published var mainVoteLiked : Int = 0
    @Published var desc : String = ""
    @Published var attrNames : [String] = []

    
    @Published var columns: Int = 3
    
    
    // LIKE - DISLIKIE
    @Published var liked : Bool = false
    @Published var deleted : Bool = false

    private var cardViewModel = CardViewModel()
    @StateObject private var chartViewModel = ChartViewModel()
    @StateObject private var voteViewModel = VoteViewModel()
    
    @Published var showProfile = false
    
    // Storing The Selected profile...
//    @Published var selectedProfile : Profile!
    
    // To Show Big Image...
    @Published var showEnlargedImage = false
    
    // Drag to close...
    @Published var offset: CGFloat = 0
    
    
    @Published var votedCards = [String]()
    @Published var flaggeCards = [String]()

    
    //All Active CAard
    @Published var activeCards = [ActiveVote]()
    @Published var compositionalArray : [[ActiveVote]] = []
    @Published var filteredCards: [ActiveVote] = []
    @Published var itemType: ItemType = .dailyLook

    
    @Published var myActiveCards = [ActiveVote]()
    @Published var mainVoteCard = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [],numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0, itemType: "")
    init(){
        if log_Status {
            refresh()
        }
//
    
    }
    
    
    
    
    func listenAuthenticationState(){
        
        
        
    }
    func resetDefaults() {
        print("resetDefaults")
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func refresh(){
      
        
//        activeCards.removeAll()
            votedCards.removeAll()
            
            getAllCard()
            checkVoted()
            getMyCards()
        
    }
    func setCompositionalLayout(){
        
        var currentArrayCards : [ActiveVote] = []
        
        activeCards.forEach { (card) in
            
            currentArrayCards.append(card)
            
            if currentArrayCards.count == 3{
                
                // appending to Main Array...
                compositionalArray.append(currentArrayCards)
                currentArrayCards.removeAll()
            }
            
            // if not 3 or Even No of cards...
            
            if currentArrayCards.count != 3 && card.id == activeCards.last!.id{
                
                // appending to Main Array...
                compositionalArray.append(currentArrayCards)
                currentArrayCards.removeAll()
            }
        }
    }
    
    func getMyCards(){
        
        self.myActiveCards.removeAll()
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.whereField("userId", isEqualTo: User.currentUser()!.id ).getDocuments { [self] (snap, err) in

            if err != nil{
                print((err?.localizedDescription)!)
                self.error = (err! as NSError)
                return
            }
            
            for i in snap!.documents{
                let dict = i.data()
                guard let decoderPost = try? ActiveVote.init(fromDictionary: dict) else {return}
                self.myActiveCards.append(decoderPost)
                
            }
            //            self.isReloading = false
            
            self.myActiveCards = self.myActiveCards.sorted(by: { $0.lastModifiedDate > $1.lastModifiedDate })

            while (self.myActiveCards.count < MY_CARD_LIMIT_TO_QUERY){
                
                let dummyCard = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [], numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0, itemType: "")
                self.myActiveCards.append(dummyCard)
                
            }

            
//            while (self.myActiveCards.count > 6){
//                self.myActiveCards.removeLast()
//            }
            if(!self.myActiveCards.isEmpty && self.myActiveCards[0].imageLocation != ""){
                self.desc = self.myActiveCards[0].description
                loadMainVoteChartData(postId: self.myActiveCards[0].id.uuidString)
            }
            
        }

    }
    
    func getAllCard(){
        

        Ref.FIRESTORE_COLLECTION_FLAG_USERID(userId: User.currentUser()!.id).collection("flagged").getDocuments { [self] (snap, err) in
            self.flaggeCards.removeAll()

            if err != nil{
                print((err?.localizedDescription)!)
                self.error = (err! as NSError)
                return
            }

            for i in snap!.documents{
                self.flaggeCards.append(i.documentID)
            }
            
            Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.limit(to: CARD_LIMIT_TO_QUERY).order(by: "lastModifiedDate", descending: true).getDocuments { (snapshot, err) in
                //            self.activeCards.removeAll()
                self.activeCards.removeAll()
                
                if err != nil{
                    print((err?.localizedDescription)!)
                    self.error = (err! as NSError)
                    return
                }
                
                for i in snapshot!.documents{
                    
                    let id = i.documentID
                    if(id != Auth.auth().currentUser?.uid){
                        
                        let dict = i.data()
                        guard let decoderPost = try? ActiveVote.init(fromDictionary: dict) else {return}
                        
                        if(!self.flaggeCards.contains(decoderPost.id.uuidString)){
                            self.activeCards.append(decoderPost)
                            
                        }
                        
                    }
                    
                }
                
                self.activeCards = self.activeCards.sorted(by: { $0.lastModifiedDate > $1.lastModifiedDate })
                print("self.activeCards.count \(self.activeCards.count)")
                
                
                
            }

    //        DispatchQueue.main.async {
    //            print("self.activeCards.count \(self.activeCards.count)")
    //            if !self.activeCards.isEmpty{self.setCompositionalLayout()}
    //        }
        }
        
        
        
    
    }
    
    
    func removeVoteFromCardList(postId: UUID){
        
        if let idx = self.activeCards.firstIndex(where: { $0.id == postId}) {
            self.activeCards.remove(at: idx)
        }
        self.activeCards = self.activeCards.sorted(by: { $0.lastModifiedDate > $1.lastModifiedDate })

    }
    
    func disLikePost(postId : String){
        self.cardViewModel.disLikePost(postId: postId) { result in
            self.liked = result
        }
    }
    
    func likePost(post: ActiveVote ){
        self.cardViewModel.likePost(post: post) { result in
            
            self.liked = result
            
            
        }
    }
    
    func checkLiked(postId : String){
        cardViewModel.checkLiked(postId: postId) { result in
            self.liked = result
        }
    }

    
    func isDeleted(postId : String ,onSuccess: @escaping(_ result: Bool) -> Void){
        cardViewModel.isDeleted(postId: postId) { result in
          
            
            onSuccess(result)

        }
    }

    
    
    
    func checkVoted(){
        self.votedCards.removeAll()
        
        Ref.FIRESTORE_COLLECTION_MYVOTE.document(User.currentUser()!.id).collection("voted").order(by: "lastModifiedDate", descending: true).addSnapshotListener ({ (snapshot, error) in
            
            
            snapshot!.documentChanges.forEach { (documentChange) in
                
                switch documentChange.type {
                case .added:
                    print("type: added")
                    
                    let dict = documentChange.document.data()
                    guard let decoderActivity = try? ActiveVote.init(fromDictionary: dict) else {return}
                    self.votedCards.append(decoderActivity.id.uuidString)
                    //
                case .modified:
                    print("type: modified")
                    
                case .removed:
                    print("type: removed")
                }
                
                print("self.votedCards size is \(self.votedCards.count)")
                
            }
        })
    }
    
    
    func deleteVote(postId : String){
//        resetVoteData()
        self.cardViewModel.deletePost(postId: postId) { result in
            print("deleteVote")
            self.getMyCards()

        }
    }
    
    
    
    func loadMainVoteChartData(postId: String){
        
        resetVoteData()
        isLoading = true
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE_POSTID(postId: postId).addSnapshotListener { (querySnapshot, error) in
            guard let document = querySnapshot else {
                print("No documents")
                return
            }
            
            var vote : ActiveVote?
            
            if(document.documentID == postId && document.data() != nil){
                let _dictionary = document.data()

//                let dict = document.data()!
                guard let decoderVote = try? ActiveVote.init(fromDictionary: _dictionary) else {return}
                vote = decoderVote
                self.desc = vote!.description

                if(vote!.numVote == 0){
                    self.mainVoteData = [0,0,0]
                }else{
                    let attr1 = (Double(vote!.attr1) / Double(vote!.numVote) * 100).roundToDecimal(1)
                    let attr2 = (Double(vote!.attr2) / Double(vote!.numVote) * 100).roundToDecimal(1)
                    let attr3 = (Double(vote!.attr3) / Double(vote!.numVote) * 100).roundToDecimal(1)
                    
                    
                    self.mainVoteData = [attr1, attr2, attr3]
                    self.mainVoteNum = vote!.numVote
                    self.mainVoteLiked = vote!.numLiked
                    self.attrNames = vote!.attrNames
                    
                }
                
            }
//            else{
//                data = Vote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], numVote: 0, createdDate: 0, lastModifiedDate: 0, imageLocation : User.currentUser()!.profileImageUrl)
//            }
//            self.isLoading = false
         
            
            
        }
        

    }
    
    func resetVoteData(){
        mainVoteData = [0, 0, 0]
        mainVoteNum = 0
        mainVoteLiked = 0
        attrNames = []
    }
    
    
    
    
    
    
    func loadChartData(postId: String, onSuccess: @escaping(_ voteData: [Double], _ numVote: Int, _ numLiked: Int) -> Void){
        var voteData = [Double]()
        var numVote : Int = 0
        var numLiked : Int = 0
        
        self.chartViewModel.loadChartData(postId: postId) { (vote) in
            if(vote.numVote == 0){
                voteData = [0,0,0]
            }else{
                let attr1 = (Double(vote.attr1) / Double(vote.numVote) * 100).roundToDecimal(1)
                let attr2 = (Double(vote.attr2) / Double(vote.numVote) * 100).roundToDecimal(1)
                let attr3 = (Double(vote.attr3) / Double(vote.numVote) * 100).roundToDecimal(1)
                
                voteData = [attr1, attr2, attr3]
                numVote = vote.numVote
                numLiked = vote.numLiked
            }
            
            
            onSuccess(voteData, numVote , numLiked)
        }
    }
    
    func flagPicture(reason: String, vote:ActiveVote , onSuccess: @escaping(_ result: Bool) -> Void){
        var result : Bool = false
        let batch = Ref.FIRESTORE_ROOT.batch()
        let flag = Flag(vote: vote, email: User.currentUser()!.email, username: User.currentUser()!.username, reason: reason, date: Date().timeIntervalSince1970)

        guard let dict = try? flag.toDictionary() else { return }
//        let flagId = Ref.FIRESTORE_COLLECTION_FLAG_USERID(userId: User.currentUser()!.id).collection("flagged").document().documentID
        let flaggedRef = Ref.FIRESTORE_COLLECTION_FLAG_USERID(userId: User.currentUser()!.id).collection("flagged").document(vote.id.uuidString)
        batch.setData(dict, forDocument: flaggedRef)
        
        
        batch.setData(dict, forDocument: flaggedRef)
        
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch addToMyList write succeeded.")
                result = true
                onSuccess(result)
            }
        }

    }
    
    
    
    func persist(votePost:  ActiveVote, buttonPressed:[Bool]) {
        
        var post :ActiveVote = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [],tags: [],  numVote: 0,  createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: TOKEN, numLiked: 0, itemType: "")
        post  = votePost
        //batch writing. vote multiple entries
        let batch = Ref.FIRESTORE_ROOT.batch()
        
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
        guard let dict = try? post.toDictionary() else {return}
        let myVoteRef = Ref.FIRESTORE_COLLECTION_MYVOTE_USERID(postId:id)
        
        //        let myVote = MyVote(userId: id, myVotes: updatedValueDict, attrNames: buttonTitle, voteDate: Date().timeIntervalSince1970, comment: "")
        //        guard let dict = try? myVote.toDictionary() else {return}
        batch.setData(dict, forDocument: myVoteRef)
        
        
        
        //
        //                let someoneVoteObject = Activity(activityId: User.currentUser()!.id, type: "voted", username: User.currentUser()!.username, userId: User.currentUser()!.id, userAvatar: User.currentUser()!.profileImageUrl, message: "", date: Date().timeIntervalSince1970, read: false, age: User.currentUserProfile()!.age, location: User.currentUserProfile()!.location,occupation: User.currentUserProfile()!.occupation, description: User.currentUserProfile()!.description)
//
//
//        guard let someOneVotedDict = try? currentUser.toDictionary() else { return }
//        let someOneVoteRef  = Ref.FIRESTORE_COLLECTION_WHO_VOTED_USERID(postId: id)
//        batch.setData(someOneVotedDict, forDocument: someOneVoteRef)
        
        
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
                self.isSucess = true
                
                
            }
        }
        
        
        
    }
    
    
    
}
