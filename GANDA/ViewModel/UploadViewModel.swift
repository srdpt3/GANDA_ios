//
//  UploadViewModel.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/3/22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage

class UploadViewModel: ObservableObject {
    @Published var isSucess = false
    @Published var isLoading = false
    //     var buttonPressed = [Bool]()
    var selectedButton = [String]()
    

    func uploadVote(title : String, selectionText: [String], tags : [Tag],imageData: Data) {
        self.isLoading = true
        let date: Double = Date().timeIntervalSince1970
        let myVote = Vote.init(id: UUID(), attr1: 0, attr2 : 0 , attr3 : 0 , attr4: 0, attr5: 0,title: title, tags:tags, attrNames: selectionText, numVote: 0, createdDate: date, lastModifiedDate: date, imageLocation: "")
        
        let storageAvatarUserId = Ref.STORAGE_VOTE_PIC_USERID(userId: UUID().uuidString)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
//        StorageService.saveVotePicture(myVote: myVote , userId: User.currentUser()!.id, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId)
        StorageService.saveVotePicture(myVote: myVote , userId: User.currentUser()!.id, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId)

        Ref.FIRESTORE_COLLECTION_WHO_VOTED.document( UUID().uuidString).collection("voted").getDocuments { (snapshot, error) in
            if error == nil {
                print("error for deleting someone voted me")
            }
            
            for doc in snapshot!.documents {
                doc.reference.delete()
                
                
            }
        }
        
        
        
        self.isLoading = false

        
 
    }
}



