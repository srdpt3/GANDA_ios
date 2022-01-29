//
//  FlagView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/9/22.
//


import SwiftUI


struct FlagView : View {
    @EnvironmentObject  var obs : Observer
    @Binding var selected : String
    @Binding var show : Bool
    @Binding var flagMessage : Bool
    @Binding var flagComplete : Bool
    @Binding var activeAlert : ActiveAlert
    
    var selectedVote : ActiveVote
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
   
                    self.obs.flagPicture(reason: self.selected, vote: selectedVote) { result in
                        
                        self.obs.removeVoteFromCardList(postId: selectedVote.id)
                        self.obs.flaggeCards.append(selectedVote.id.uuidString)
                        
                        flagComplete.toggle()
                      
                        self.activeAlert = ActiveAlert.flag

                        self.selected  = ""
 
                    }
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



