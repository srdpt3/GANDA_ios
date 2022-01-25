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
    @Published var columns: Int = 3
    
    
    // LIKE - DISLIKIE
    @Published var liked : Bool = false

    //    @State var buttonTitle : [String] = ["나는코린이다", "빨간구두가 잘어울린다","돈잘벌꺼같다"]
    @State var numVoteData:[Int] = [0,0,0]
    
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
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.whereField("userId", isEqualTo: User.currentUser()!.id ).limit(to: MY_CARD_LIMIT_TO_QUERY).addSnapshotListener ({ [self] (snapshot, error) in
            snapshot!.documentChanges.forEach { (documentChange) in
                
                switch documentChange.type {
                case .added:
                    print("type: added")
                    
                    let dict = documentChange.document.data()
                    guard let decoderActivity = try? ActiveVote.init(fromDictionary: dict) else {return}
                    self.myActiveCards.append(decoderActivity)
                    print("self.activeCards.count \(self.myActiveCards.count)")
                case .modified:
                    print("type: modified")

                case .removed:
                    let dict = documentChange.document.data()
                    guard let decoderActivity = try? ActiveVote.init(fromDictionary: dict) else {return}
         
                    if let selectionIndex = self.myActiveCards.firstIndex(of: decoderActivity){
                        self.myActiveCards.remove(at: selectionIndex)
                    }
                    
                }
                print("self.activeCards.count \(self.myActiveCards.count)")
                self.myActiveCards = self.myActiveCards.sorted(by: { $0.lastModifiedDate > $1.lastModifiedDate })
//                DispatchQueue.main.async {
//                    print("self.activeCards.count \(self.activeCards.count)")
//                    if !self.activeCards.isEmpty{self.setCompositionalLayout()}
//                }

            }
            

            while (self.myActiveCards.count < MY_CARD_LIMIT_TO_QUERY){
                
                let dummyCard = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [], numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0, itemType: "")
                self.myActiveCards.append(dummyCard)
                
            }
            
            while (self.myActiveCards.count > 6){
                self.myActiveCards.removeLast()
            }
            self.myActiveCards = self.myActiveCards.sorted(by: { $0.lastModifiedDate > $1.lastModifiedDate })

            print("self.myActiveCards.count \(self.myActiveCards.count)")
            if(self.myActiveCards[0].imageLocation != ""){
                loadMainVoteChartData(postId: self.myActiveCards[0].id.uuidString)
            }
        })
    }
    func getAllCard(){
        
        Ref.FIRESTORE_COLLECTION_ACTIVE_VOTE.limit(to: CARD_LIMIT_TO_QUERY).order(by: "lastModifiedDate", descending: true).addSnapshotListener ({ (snapshot, error) in

            snapshot!.documentChanges.forEach { (documentChange) in
                
                switch documentChange.type {
                case .added:
                    print("type: added")
                    
                    let dict = documentChange.document.data()
                    guard let decoderActivity = try? ActiveVote.init(fromDictionary: dict) else {return}
                    self.activeCards.append(decoderActivity)
                case .modified:
                    print("type: modified")

                case .removed:
                    let dict = documentChange.document.data()
                    guard let decoderActivity = try? ActiveVote.init(fromDictionary: dict) else {return}
         
                    if let selectionIndex = self.activeCards.firstIndex(of: decoderActivity){
                        self.activeCards.remove(at: selectionIndex)

                    }
                    

                    
                }
//                if !self.activeCards.isEmpty{self.setCompositionalLayout()}
//                print("self.votedCards size is \(self.votedCards.count)")
                self.activeCards = self.activeCards.sorted(by: { $0.lastModifiedDate > $1.lastModifiedDate })
//                DispatchQueue.main.async {
//                    print("self.activeCards.count \(self.activeCards.count)")
//                    if !self.activeCards.isEmpty{self.setCompositionalLayout()}
//                }

            }
            
            
            while (self.activeCards.count % 5 != 0){
                
                let dummyCard = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [], numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0, itemType: "")
                self.activeCards.append(dummyCard)
                
            }
            print("self.activeCards size is \(self.activeCards.count)")
        })
        
//        DispatchQueue.main.async {
//            print("self.activeCards.count \(self.activeCards.count)")
//            if !self.activeCards.isEmpty{self.setCompositionalLayout()}
//        }
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
        self.cardViewModel.deletePost(postId: postId) { result in
            
        }
    }
    
    
    
    func loadMainVoteChartData(postId: String){
        self.mainVoteNum = 0
        self.mainVoteLiked = 0
        self.mainVoteData.removeAll()
    
        self.chartViewModel.loadChartData(postId: postId) {(vote) in
            if(vote.numVote == 0){
                self.mainVoteData = [0,0,0]
            }else{
                let attr1 = (Double(vote.attr1) / Double(vote.numVote) * 100).roundToDecimal(1)
                let attr2 = (Double(vote.attr2) / Double(vote.numVote) * 100).roundToDecimal(1)
                let attr3 = (Double(vote.attr3) / Double(vote.numVote) * 100).roundToDecimal(1)
                
                self.mainVoteData = [attr1, attr2, attr3]
                self.mainVoteNum = vote.numVote
                self.mainVoteLiked = vote.numLiked
            }
        }
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
    
    
    func persist(votePost:  ActiveVote, buttonPressed:[Bool]) {
        
        var post :ActiveVote = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [],tags: [],  numVote: 0,  createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: TOKEN, numLiked: 0, itemType: "")
        post  = votePost
        //batch writing. vote multiple entries
        let batch = Ref.FIRESTORE_ROOT.batch()
        let currentUser = User.currentUser()!
        
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
