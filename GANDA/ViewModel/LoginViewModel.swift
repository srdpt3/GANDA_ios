//
//  LoginViewModel.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/29/21.
//

import SwiftUI
import CryptoKit
import AuthenticationServices
import Firebase

class LoginViewModel: ObservableObject{
    @EnvironmentObject var observer: Observer

    @Published var nonce = ""
    @AppStorage("isLogged") var log_Status = false
    
    func authenticate(credential: ASAuthorizationAppleIDCredential){
        
        // getting Token....
        guard let token = credential.identityToken else{
            print("error with firebase")
            
            return
        }
        
        // Token String...
        guard let tokenString = String(data: token, encoding: .utf8) else{
            print("error with Token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString,rawNonce: nonce)
//        self.log_Status = true
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in

            if let error = err{
                print(error.localizedDescription)
                return
            }
            AuthService.resetDefaults()
            URLCache.shared.removeAllCachedResponses()
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            // Displaying User Name...
            guard let user = result?.user else{
                return
            }
            
//                let photoURL = user.photoURL?.absoluteURL?.absoluteString
            
//            print(user.displayName ?? "Success!")
            print(user)
//                let profileImageULR = user.photoURL?.absoluteString  as String ?? ""
                
//            let profileImageULR = (user.photoURL)! as URL
            
                
            let userData = User.init(id: user.uid, email: user.email! , profileImageUrl: "", username: "" , sex: "", createdDate:  Date().timeIntervalSince1970, point_avail: 3000, token: TOKEN)
            
            guard let dict = try? userData.toDictionary() else {return}
            
            let batch = Ref.FIRESTORE_ROOT.batch()
            let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: user.uid)
            batch.setData(dict, forDocument: firestoreUserId)
            
            batch.commit() { [self] err in
                if let err = err {
                    print("Error writing batch \(err)")
                } else {
                    print("Batch persistMatching write succeeded.")
                    saveUserLocally(mUserDictionary: dict as NSDictionary)
                    self.observer.activeCards.removeAll()

                    self.observer.refresh()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation() {
                            self.log_Status = true
                        }
                    }
                }
            }
            
            
            
            
        }
    }
}

func sha256(_ input: String) -> String {
 let inputData = Data(input.utf8)
 let hashedData = SHA256.hash(data: inputData)
 let hashString = hashedData.compactMap {
   return String(format: "%02x", $0)
 }.joined()

 return hashString
}

func randomNonceString(length: Int = 32) -> String {
 precondition(length > 0)
 let charset: Array<Character> =
     Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
 var result = ""
 var remainingLength = length

 while remainingLength > 0 {
   let randoms: [UInt8] = (0 ..< 16).map { _ in
     var random: UInt8 = 0
     let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
     if errorCode != errSecSuccess {
       fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
     }
     return random
   }

   randoms.forEach { random in
     if remainingLength == 0 {
       return
     }

     if random < charset.count {
       result.append(charset[Int(random)])
       remainingLength -= 1
     }
   }
 }

 return result
}
