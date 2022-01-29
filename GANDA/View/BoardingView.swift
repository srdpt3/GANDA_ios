//
//  BoardingView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/29/21.
//
import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices

@available(iOS 15, *)
struct BoardingView: View {
    @StateObject var loginData = LoginViewModel()
    @EnvironmentObject var observer: Observer

    // Loading Indicator...
    @State var isLoading: Bool = false
    
    @AppStorage("isLogged") var log_Status = false
    // Titles and subtitles...
    @State var titles = [
        
        "오늘 내 옷 스타일 어때?",
        "자유롭게 나만의 스타일을 표현",
        "최신 옷 트랜드를 파악해보세요"
    ]
    
    @State var subTitles = [
        
        "패션 스타일 통해 사람들과 소통할 수 있는 공간",
        "사람들의 스타일에 투표를 하고 나도 받고..",
        "내 스타일 찾아서 GANDA",
    ]
    
    // Animations....
    // to get intial change...
    @State var currentIndex: Int = 2
    
    @State var titleText: [TextAnimation] = []
    
    @State var subTitleAnimation: Bool = false
    @State var endAnimation = false
    
    var body: some View {
        
        ZStack{
            
            // Geometry reader for SCreen Size...
            GeometryReader{proxy in
                
                let size = proxy.size
                
                // since for opacity animation...
                Color.black
                
                // changing image...
                // make sure to have only same images as titles...
                ForEach(1...3,id: \.self){index in
                    
                    Image("Pic\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .opacity(currentIndex == (index - 1) ? 1 : 0)
                }
                
                // Linear Gradient...
                LinearGradient(colors: [
                    
                    .clear,
                    .black.opacity(0.5),
                    .black
                ], startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
            
            // Bottom Content...
            VStack(spacing: 20){
                
                HStack(spacing: 0){
                    
                    ForEach(titleText){text in
                        
                        Text(text.text)
                            .offset(y: text.offset)
                    }
                    .font(.largeTitle.bold())
                }
                .offset(y: endAnimation ? -80 : 0)
                .opacity(endAnimation ? 0 : 1)
                
                Text(subTitles[currentIndex])
                    .opacity(0.7)
                    .offset(y: !subTitleAnimation ? 60 : 0)
                    .offset(y: endAnimation ? -80 : 0)
                    .opacity(endAnimation ? 0 : 1)
                
                // Sign In Buttons...
                
//                SignInButton(image: "applelogo", text: "Continue with Apple", isSystem: true) {
//
//
//                }
                Text("").padding()
//                .padding(.top)
                //                SignInWithAppleButton { (request) in
                //
                //                    //                    // requesting paramertes from apple login...
                //                    loginData.nonce = randomNonceString()
                //                    request.requestedScopes = [.email]
                //                    request.nonce = sha256(loginData.nonce)
                //
                //                } onCompletion: { (result) in
                //
                //
                //                    switch result{
                //                    case .success(let user):
                //                        print("success")
                //                        // do Login With Firebase...
                //                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                //                            print("error with firebase")
                //                            return
                //                        }
                //                        loginData.authenticate(credential: credential)
                //                    case.failure(let error):
                //                        print(error.localizedDescription)
                //                    }
                //                }
                //                .signInWithAppleButtonStyle(.white)
                //                .frame(height: 55)
                //                .clipShape(Capsule())
                //                .padding(.horizontal,40)
                //                .offset(y: -10)
                //                .padding(.top)
                SignInButton(image: "google", text: "Continue with Google", isSystem: false){
                    print("asdfsadfsadf")
                    handleLogin()
                }
                //
                //                SignInButton(image: "facebook", text: "Continue with Facebook", isSystem: false) {
                //
                //
                //                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .onAppear(perform: {
            currentIndex = 0
        })
        .onChange(of: currentIndex) { newValue in
            
            // Updating and resetting if last index comes....
            getSpilitedText(text: titles[currentIndex]){
                
                // removing the current one and updating index....
                withAnimation(.easeInOut(duration: 1)){
                    endAnimation.toggle()
                }
                
                // Updating Index...
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    
                    // removing title text..
                    titleText.removeAll()
                    subTitleAnimation.toggle()
                    endAnimation.toggle()
                    
                    // updating index...
                    withAnimation(.easeIn(duration: 0.6)){
                        
                        if currentIndex < (titles.count - 1){
                            currentIndex += 1
                        }
                        else{
                            // setting back to 0..
                            // so it will be endless loop...
                            currentIndex = 0
                        }
                    }
                }
            }
        }
    }
    
    // Spilting Text into array of characters and animating it...
    // Completion handler to inform the animation completion...
    func getSpilitedText(text: String,completion: @escaping ()->()){
        
        for (index,character) in text.enumerated(){
            
            // appending into title text...
            titleText.append(TextAnimation(text: String(character)))
            
            // With time delay setting text offset to 0...
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.03) {
                
                withAnimation(.easeInOut(duration: 0.5)){
                    titleText[index].offset = 0
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(text.count) * 0.02) {
            
            withAnimation(.easeInOut(duration: 0.5)){
                subTitleAnimation.toggle()
            }
            
            // completion...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                
                completion()
            }
        }
    }
    
    func handleLogin(){
        
        // Google Sign in...
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        isLoading = true
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {[self] user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                isLoading = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            // Firebase Auth...
            Auth.auth().signIn(with: credential) { result, err in
                
                isLoading = false
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
                
                print(user.displayName ?? "Success!")
                
//                let profileImageULR = user.photoURL?.absoluteString  as String ?? ""
                    
                let profileImageULR = (user.photoURL)! as URL
                
                    
                let userData = User.init(id: user.uid, email: user.email! , profileImageUrl: profileImageULR.absoluteString, username: user.displayName! , sex: "", createdDate:  Date().timeIntervalSince1970, point_avail: 3000, token: TOKEN)
                
                guard let dict = try? userData.toDictionary() else {return}
                
                let batch = Ref.FIRESTORE_ROOT.batch()
                let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: user.uid)
                batch.setData(dict, forDocument: firestoreUserId)
                
                batch.commit() { err in
                    if let err = err {
                        print("Error writing batch \(err)")
                    } else {
                        print("Batch persistMatching write succeeded.")
                        saveUserLocally(mUserDictionary: dict as NSDictionary)
                        self.observer.activeCards.removeAll()

                        observer.refresh()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation() {
                                log_Status = true
                            }
                        }
                    }
                }
                
                // Updating User as Logged in
            
            }
        }
    }
    
}





struct SignInButton: View{
    
    var image: String
    var text: String
    var isSystem: Bool
    
    var onClick: ()->()
    
    var body: some View{
        
        HStack{
            
            (
                
                isSystem ? Image(systemName: image) : Image(image)
            )
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .foregroundColor(!isSystem ? .white : .black)
        .padding(.vertical,15)
        .padding(.horizontal,40)
//        .background(
//            
////            .white.opacity(isSystem ? 1 : 0.1)
////            ,in: Capsule()
//        )
        .onTapGesture {
            onClick()
        }
    }
}


struct TextAnimation: Identifiable {
    var id = UUID().uuidString
    var text: String
    var offset: CGFloat = 110
}
