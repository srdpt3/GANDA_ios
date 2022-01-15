//
//  FlagView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/9/22.
//


import SwiftUI


struct FlagView : View {
//    @EnvironmentObject  var obs : observer
    @Binding var selected : String
    @Binding var show : Bool
    @Binding var flagMessage : Bool
    
    var updatedValueDict = ["attr1":0 , "attr2":0, "attr3":0, "attr4":0, "attr5":0]
    var buttonTitle : [String] = ["없음", "없음","없음", "없음", "없음"]
    
    
    func flagPicture(reason: String){
        let batch = Ref.FIRESTORE_ROOT.batch()
//
//        let currentVote = self.obs.getCurrentCard().user
//        let flag = Flag(id: currentVote.id, email: currentVote.email, imageLocation: currentVote.imageLocation, username: currentVote.username, reason: reason, reporter: User.currentUser()!.id,   date:  Date().timeIntervalSince1970)
//
//        guard let dict = try? flag.toDictionary() else { return }
//        let flagId = Ref.FIRESTORE_COLLECTION_FLAG_USERID(userId: flag.id).collection("flagged").document().documentID
//        let flaggedRef = Ref.FIRESTORE_COLLECTION_FLAG_USERID(userId: flag.id).collection("flagged").document(flagId)
//        batch.setData(dict, forDocument: flaggedRef)
//
//
//
//        let myVote = MyVote(userId: currentVote.id, myVotes: updatedValueDict, attrNames: buttonTitle, voteDate: Date().timeIntervalSince1970, comment: "FLAGGED")
//        let myVoteRef = Ref.FIRESTORE_COLLECTION_MYVOTE_USERID(userId: currentVote.id)
//
//        guard let dict2 = try? myVote.toDictionary() else {return}
//        batch.setData(dict2, forDocument: myVoteRef)
//
//        batch.commit() { err in
//            if let err = err {
//                print("Error writing batch \(err)")
//            } else {
//                print("Batch addToMyList write succeeded.")
//            }
//        }
//
//        withAnimation{
//            self.show.toggle()
//            self.flagMessage.toggle()
//            self.obs.moveCards()
//        }
//
//        self.selected = ""
    }
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                Text(FLAGPICTURE_TITLE).font(.custom(FONT, size: CGFloat(BUTTON_TITLE_FONT_SIZE)))       .foregroundColor(APP_THEME_COLOR)
                Spacer()
                Button(action: {
                    // ACTION
                    self.show.toggle()
                    //                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.white)
                        .shadow(radius: 10)
                        .opacity( 1 )
                        .scaleEffect(1.5 , anchor: .center)
                })
            }
            //            .padding(.trailing, 15)
            Divider()
            ForEach(data,id: \.self){i in
                
                Button(action: {
                    
                    self.selected = i
                    
                }) {
                    
                    HStack{
                        
                        Text(i).font(.custom(FONT, size: 14))
                        
                        Spacer()
                        
                        ZStack{
                            
                            Circle().fill(self.selected == i ? APP_THEME_COLOR : Color.black.opacity(0.2)).frame(width: 18, height: 18)
                            
                            if self.selected == i{
                                
                                Circle().stroke(APP_THEME_COLOR, lineWidth: 4).frame(width: 25, height: 25)
                            }
                        }
                        
                        
                        
                    }.foregroundColor(.black)
                    
                }.padding(.top)
            }
            
            HStack{
                
                
                Spacer()
                
                Button(action: {
                    
                    
                    
                    self.flagPicture(reason: self.selected)
                    
                }) {
                    
                    Text(BLOCK_BUTTON).padding(.vertical).padding(.horizontal,30).foregroundColor(.white)
                    
                }
                .background(
                    
                    self.selected != "" ?
                    
                    LinearGradient(gradient: .init(colors: [Color("pink"),Color("Pink-1")]), startPoint: .leading, endPoint: .trailing) :
                    LinearGradient(gradient: .init(colors: [Color.black.opacity(0.2),Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                    
                )
                .clipShape(Capsule())
                .disabled(self.selected != "" ? false : true)
                
                
            }.padding(.top)
            
        }.padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)!)
            .background(Color.white)
            .cornerRadius(30)
    }
}



