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
                        ImageGrid(img:self.observer.myActiveCards, selected: self.observer.myActiveCards[0], showingModal: $showingModal, animatingModal: $animatingModal).offset(y: -25)
                        
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
    
    var img : [ActiveVote]
    @State var selected : ActiveVote
    @Binding var showingModal: Bool
    @Binding var animatingModal: Bool
    
    
    @State var ymax : Int = 100
    @State var totalNumVote : Int = 0
    @State var totalNumLiked : Int = 0
    
    @State var deleteVote : Bool = false
    
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
                            
                            chart()
                            
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
                                                        self.selected = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [],numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0, itemType: "")
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
                                            HStack{
                                                Spacer()
                                                Button {
                                                    withAnimation(.spring(response: 0.9, dampingFraction: 1.0, blendDuration: 1.0)){
                                                        
                                                        self.deleteVote.toggle()
                                                        self.haptics.notificationOccurred(.success)
                                                    }
                                                    
                                                } label: {
                                                    Spacer()
                                                    Image(systemName: "trash")
                                                        .foregroundColor(.white)
                                                        .frame(width: 25, height: 25)
                                                        .padding(5)
                                                        .background(Color.black.opacity(0.5))
                                                        .clipShape(Circle())
                                                    
                                                }
                                            }.padding([.trailing,.bottom])
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
                            
                            
                            if self.deleteVote {
                                ZStack {
                                    
                                    //                                    APP_THEME_COLOR.edgesIgnoringSafeArea(.all)
                                    
                                    // MODAL
                                    VStack(spacing: 0) {
                                        // TITLE
                                        Text("등록한 사진 삭제")
                                            .font(Font.custom(FONT, size: 18))
                                            .fontWeight(.heavy)
                                            .padding()
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .background(APP_THEME_COLOR)
                                            .foregroundColor(Color.white)
                                        
                                        Spacer()
                                        
                                        // MESSAGE
                                        
                                        VStack(spacing: 12) {
                                            
                                            HStack{
                                                Text("투표를 종료하시겠습니까?")
                                                    .font(Font.custom(FONT, size: 14))
                                                    .lineLimit(2)
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color.gray)
                                                    .layoutPriority(1)
                                                
                                                //                                                Button(action: {
                                                //                                                }) {
                                                //
                                                //                                                    Image(systemName: "xmark.circle").resizable().frame(width: 30, height: 30).foregroundColor(Color.gray)
                                                //                                                }
                                            }
                                            
                                            
                                            
                                            HStack{
                                                Button(action: {
                                                    self.deleteVote.toggle()
                                                    
                                                }) {
                                                    Text(CANCEL.uppercased())
                                                        .font(Font.custom(FONT, size: 15))
                                                        .fontWeight(.semibold)
                                                        .accentColor(Color.gray)
                                                        .padding(.horizontal, 35)
                                                        .padding(.vertical, 10)
                                                        .frame(minWidth: 70)
                                                        .background(
                                                            Capsule()
                                                                .strokeBorder(lineWidth: 1.75)
                                                                .foregroundColor(Color.gray)
                                                        )
                                                }
                                                Button(action: {
                                                    
                                                    withAnimation(){
                                                        self.observer.deleteVote(postId: selected.id.uuidString)
                                                        
                                                        self.animatingModal.toggle()
                                                        self.self.showingModal.toggle()
                                                        self.deleteVote.toggle()
                                                    }
                                                    
                                                }) {
                                                    Text(CONFIRM.uppercased())
                                                        .font(Font.custom(FONT, size: 15))
                                                        .fontWeight(.semibold)
                                                        .accentColor(APP_THEME_COLOR)
                                                        .padding(.horizontal, 35)
                                                        .padding(.vertical, 10)
                                                        .frame(minWidth: 70)
                                                        .background(
                                                            Capsule()
                                                                .strokeBorder(lineWidth: 1.75)
                                                                .foregroundColor(APP_THEME_COLOR)
                                                        )
                                                }
                                                
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                    }
                                    .frame(minWidth: 220, idealWidth: 220, maxWidth: 260, minHeight: 130, idealHeight: 140, maxHeight: 180, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5)
                                    //                                    .shadow(color: APP_THEME_COLOR, radius: 6, x: 0, y: 8)
                                    .opacity(self.$animatingModal.wrappedValue ? 1 : 0)
                                    .offset(y: self.$animatingModal.wrappedValue ? 0 : -100)
                                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                                    .onAppear(perform: {
                                        self.animatingModal = true
                                    })
                                }
                            }
                            
                            
                            
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
            
            
            //            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            //
            //                self.numVoteData = self.observer.mainVoteData
            //                self.voteTitle =  self.observer.desc
            //                self.attrNames = self.observer.attrNames
            //
            //            }
            
        }
        
        
        
    }
    
    
    @ViewBuilder
    func chart()->some View{
        if !self.observer.myActiveCards.isEmpty {
            ChartView_BAR(data: self.$observer.mainVoteData  , totalNum: self.$ymax, title: "최근 등록된 투표", categories: self.observer.attrNames )
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
    
    
    
    @ViewBuilder
    func MyStatsDasgBoard(numVote:Int, numLiked: Int)->some View{
        
        VStack{
            
            
            // Following Followers Stats...
            
            HStack(spacing: 10){
                
                StatView(title: VOTENUM, count: numVote, image: "person.2", color: GRADIENT_COLORS[0])
                
                StatView(title: LIKENUM, count: numLiked, image: "suit.heart", color: GRADIENT_COLORS[1])
                
                
                //                if(User.currentUser() != nil){
                //                    StatView(title: POINTNUM, count: User.currentUser()!.point_avail, image: "bitcoinsign.circle", color: GRADIENT_COLORS[2])
                //
                //                }
                
            }
            
            Spacer(minLength: 0)
            
            //            .padding(.top)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        
        //        BannerAd(unitID: BANNER_UNIT_ID).padding(.horizontal)
    }
    
    @ViewBuilder
    func StatView(title: String,count: Int,image: String,color: LinearGradient)->some View{
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                Spacer()
                Image(systemName: image)
                Text(title).font(Font.custom(FONT, size: 15).bold())
                Spacer()
            }
            HStack{
                Spacer()
                Text(String(count)).font(Font.custom(FONT, size: 15))
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
            
            Image("")
                .resizable()
                .background(GRADIENT_COLORS[GRADIENT_COLORS.count - 1])
//                .foregroundColor(GRADIENT_COLORS[GRADIENT_COLORS.count - 1])
                .shadow(color: Color.black.opacity(0.3), radius: 1, x: 1, y: 1)
                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                .frame(height :isMainPic ? 270 : 130)
            
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
//                    .frame(height: 135)
            }
            
        }
        
        
    }
    
}
