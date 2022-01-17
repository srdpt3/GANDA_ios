//
//  MyPageView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/2/22.
//

import SwiftUI
import SDWebImageSwiftUI
struct MyPageView: View {
    
    @State  var showingModal: Bool = false
    @State  var animatingModal: Bool = false
    
    @EnvironmentObject var observer : Observer

    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                if !self.observer.myActiveCards.isEmpty {
                    VStack(spacing:10) {
                        ImageGrid(img:self.$observer.myActiveCards, selected: self.observer.myActiveCards[0], showingModal: $showingModal, animatingModal: $animatingModal).offset(y: -25)
                        
                    }     .toolbar {
                        
                        ToolbarItem(placement: .automatic) {
                            
                            Image(APP_LOGO)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .padding(.leading, 80)
                            
                        }
                        
                    }
                    
                }
            }
            
            
            
            
        }
    }
    
    
    
    
    
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}


struct ImageGrid : View {
    @EnvironmentObject var observer : Observer
    let haptics = UINotificationFeedbackGenerator()

    @Binding var img : [ActiveVote]
    @State var selected : ActiveVote
    @Binding var showingModal: Bool
    @Binding var animatingModal: Bool
    
//    @State var voteData:[Double] = []
//
    @State var numVoteData:[Int] = [0,0,0]
    @State var ymax : Int = 100
    @State var totalNumVote : Int = 0
    @State var totalNumLiked : Int = 0

    
    
    @State var isAnimating : Bool = true
   @State var voteDataOneCard:[Double] = []
    
    var body: some View {
        
        VStack(spacing: 10){
            GeometryReader{geo in
                
                VStack{
                    
                    HStack{
                        Spacer()
                        
                        ProgressImageView(pic: img[0], seclectedPic: $selected, isMainPic: true, showingModal: $showingModal, animatingModal: $animatingModal,voteDataOneCard:$voteDataOneCard)
                            .padding(.leading, -8.8)
                        VStack{
                            ProgressImageView(pic: img[1], seclectedPic: $selected, isMainPic: false, showingModal: $showingModal,animatingModal: $animatingModal, voteDataOneCard:$voteDataOneCard)
                            ProgressImageView(pic: img[2], seclectedPic: $selected, isMainPic: false, showingModal: $showingModal,animatingModal: $animatingModal,voteDataOneCard:$voteDataOneCard)
                            
                        }.frame(width : geo.size.width / 3 - 13 , height: 270)
                    }
                    HStack{
                        ProgressImageView(pic: img[3], seclectedPic: $selected, isMainPic: false, showingModal: $showingModal,animatingModal: $animatingModal, voteDataOneCard:$voteDataOneCard)
                        ProgressImageView(pic: img[4], seclectedPic: $selected, isMainPic: false, showingModal: $showingModal, animatingModal: $animatingModal,voteDataOneCard:$voteDataOneCard)
                        ProgressImageView(pic: img[5], seclectedPic: $selected, isMainPic: false, showingModal: $showingModal, animatingModal: $animatingModal,voteDataOneCard:$voteDataOneCard)
                        
                    }.frame(height: 135, alignment: .leading)
                    
                    VStack(alignment: .leading,spacing: 5){
                        HStack{
                            
                            if self.img[0].description != ""{
                                ChartView_BAR(data: self.$observer.mainVoteData, totalNum: self.$ymax, title: self.img[0].description, categories: self.img[0].attrNames)
                                    .frame( height: 170)
                            }else{
                                HStack{
                                    Spacer()
                                    LottieView(filename: "no-data").frame( height: 170)
                                    
                                    Text("참여중인 사진이 없어요")
                                        .font(Font.custom(FONT, size: 14))
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color("Gray")).padding(.trailing)
                                    Spacer()
                                }
                               
                                
                            }
                            
                        }
                        
                    }
                    //                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                    .padding(.horizontal, 1)
                    .padding(.top, 3)
                    MyStatsDasgBoard(numVote: observer.mainVoteNum, numLiked: observer.mainVoteLiked)
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                        .padding(.horizontal, 1)
                    
                }.padding(.horizontal, 12)
                    .blur(radius: self.$showingModal.wrappedValue ? 5 : 0, opaque: false)
                    .offset(y:-20)
                
                
                
                if self.showingModal {
                    HStack(spacing: 0) {
                        
                        Spacer()
                        ZStack {
                            
                            VStack(spacing: 0) {
                                
                                AnimatedImage(url: URL(string: selected.imageLocation),isAnimating:$isAnimating).resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geo.size.width / 1.2, height: 310)
                                    .cornerRadius(20).overlay(
                                        VStack{
                                            HStack{
                                                Spacer()
                                                Button {
                                                    withAnimation(.spring(response: 0.9, dampingFraction: 1.0, blendDuration: 1.0)){
                                                        
                                                        self.showingModal.toggle()
                                                        self.haptics.notificationOccurred(.success)
                                                    }
                                                    
                                                } label: {
                                                    Spacer()
                                                    Image(systemName: "xmark")
                                                        .foregroundColor(.white)
                                                        .frame(width: 25, height: 25)
                                                        .padding(5)
                                                        .background(Color.black.opacity(0.5))
                                                        .clipShape(Circle())
                                                    
                                                }
                                            }.padding(.trailing)
                                                .padding(.top)
                                            Spacer()
                                        }
                                        
                                        
                                        
                                        
                                    )
                                
                                if !self.voteDataOneCard.isEmpty {
                                    ChartView_BAR(data: self.$voteDataOneCard, totalNum: self.$ymax, title: selected.description , categories: selected.attrNames)
                                        .frame(width: geo.size.width / 1.3, height: 180).padding(.horizontal)
                                }
                                
                                Spacer()
                                
                            }
                            
                            .frame(width: geo.size.width / 1.3, height: 520)
                            .background(Color.white)
                            .cornerRadius(20)
                            //                            .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                            .shadow(color: Color.black.opacity(0.3), radius: 1, x: 1, y: 1)
                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                            
                            .opacity(self.$animatingModal.wrappedValue ? 1 : 0)
                            .offset(y: self.$animatingModal.wrappedValue ? 0 : -100)
                            .animation(
                                Animation.spring(response: 0.9, dampingFraction: 1.0, blendDuration: 1.0))
                            .onAppear(perform: {
                                self.animatingModal = true
                            }).offset(y: 50)
                            //                        .padding(.horizontal)
                        }
                        Spacer()
                    }
                    
                }
            }
        }
        .background(
            Color("BG")
                .ignoresSafeArea()
        )
        .onAppear {
        
            
        }
        
        
        
    }
    
    
    
    @ViewBuilder
    func MyStatsDasgBoard(numVote:Int, numLiked: Int)->some View{
        
        VStack{
            
            
            // Following Followers Stats...
            
            HStack(spacing: 10){
                
                StatView(title: VOTENUM, count: numVote, image: "person.2", color: GRADIENT_COLORS[0])
                
                StatView(title: LIKENUM, count: numLiked, image: "suit.heart", color: GRADIENT_COLORS[1])
                
                
                if(User.currentUser() != nil){
                    StatView(title: POINTNUM, count: User.currentUser()!.point_avail, image: "bitcoinsign.circle", color: GRADIENT_COLORS[2])

                }

            }
            //            .padding(.top)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
    }
    
    @ViewBuilder
    func StatView(title: String,count: Int,image: String,color: LinearGradient)->some View{
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
//                Spacer()
                Image(systemName: image)
                Text(title).font(Font.custom(FONT, size: 14))
                Spacer()
            }
            HStack{
                Spacer()
                Text(String(count)).font(Font.custom(FONT, size: 16))
                Spacer()
                
            }
            //                .font(.title.bold())
        }
        .foregroundColor(Color("BG"))
        .padding(.vertical,10)
        .padding(.horizontal,9)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(color)
        .cornerRadius(15)
    }
    
    
}


struct ProgressImageView: View {
    
    var pic : ActiveVote
    @Binding var seclectedPic : ActiveVote
    var isMainPic : Bool = false
    @Binding var showingModal : Bool
    @Binding var animatingModal : Bool
    @Binding var voteDataOneCard:[Double]
    @EnvironmentObject var observer : Observer
    
    
    var body: some View {
        
        if pic.imageLocation == ""{
//            if(isMainPic){
//                Image("")
//                    .resizable()
//                    .background(GRADIENT_COLORS[GRADIENT_COLORS.count - 1])
//                    .shadow(color: Color.black.opacity(0.3), radius: 1, x: 1, y: 1)
//                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
//                    .frame(height: 270)
//            }else{
                Image("")
                    .resizable()
                    .background(GRADIENT_COLORS[GRADIENT_COLORS.count - 1])

                    .shadow(color: Color.black.opacity(0.3), radius: 1, x: 1, y: 1)
                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                    .frame(height :isMainPic ? 270 : 135)
//            }

        }else{
            
            if(isMainPic){
                AnimatedImage(url: URL(string: pic.imageLocation)).resizable()
                    .onTapGesture {
                        seclectedPic = pic
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                              
                                observer.loadChartData(postId: pic.id.uuidString) { voteData , numVote, numLiked in
                                    voteDataOneCard = voteData
                                    showingModal.toggle()
                                }
                            }
                            
                        
                        }
                    }
                    .frame(height: 270)
            }else{
                AnimatedImage(url: URL(string: pic.imageLocation)).resizable()
                    .onTapGesture {
                        seclectedPic = pic
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                              
                                observer.loadChartData(postId: pic.id.uuidString) { voteData , numVote, numLiked in
                                    voteDataOneCard = voteData
                                    showingModal.toggle()
                                }
                            }
                            
                        }
                        
                      
                    }
            }
            
        }
        
        
    }
    
}
