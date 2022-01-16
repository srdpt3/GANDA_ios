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
    
    @EnvironmentObject var observer : Observer

    @Published var isSucess = false
    @Published var isLoading = false
    //     var buttonPressed = [Bool]()
    var selectedButton = [String]()
    

    func uploadVote(title : String, selectionText: [String], tags : [Tag],imageData: Data , onSuccess: @escaping(_ success: Bool ) -> Void) {
        var success : Bool = false
        let date: Double = Date().timeIntervalSince1970
        let myVote = Vote.init(id: UUID(), attr1: 0, attr2 : 0 , attr3 : 0 , attr4: 0, attr5: 0,title: title, tags:tags, attrNames: selectionText, numVote: 0, createdDate: date, lastModifiedDate: date, imageLocation: "")
        
        let storageAvatarUserId = Ref.STORAGE_VOTE_PIC_USERID(userId: UUID().uuidString)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
//        StorageService.saveVotePicture(myVote: myVote , userId: User.currentUser()!.id, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId)
        StorageService.saveVotePicture(myVote: myVote , userId: User.currentUser()!.id, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId) { result in
            onSuccess(success)
        }

        
        
     
        
 
    }
}



