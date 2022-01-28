//
//  SwiftUIView.swift
//  GANDA
//
//  Created by Dustin yang on 1/27/22.
//


import SwiftUI
import SDWebImageSwiftUI


struct categoryButtonView: View {
  @State var selectedBtn: String
  @Binding var searchText : String
    @State private var selected = false
  var body: some View{
      Button(action: {
          print(selectedBtn)
          searchText = selectedBtn
          selected.toggle()
      }){
          Text(selectedBtn)
              .font(.subheadline).foregroundColor(searchText == selectedBtn ? APP_THEME_COLOR : .black)
              .frame(height: 30)
              .padding(.horizontal)
              .overlay (
                Capsule()
                    .stroke(Color(.systemGray5), lineWidth: 1))
          
      }
  }
}




struct FeedView: View {
    @State var searchText = "전체"
    @State var isSearching = false
    @State var showResults = false
    @State var loadSearch = false
    
    @EnvironmentObject var observer : Observer
    
    let icon_size =  UIScreen.main.bounds.height <  926.0 ? 25 : 30
    let logo_size =  UIScreen.main.bounds.height < 926.0 ? 30 : 35
    
    @Binding var showDetailView : Bool
    
    @State var selected  = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [],numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0, itemType: "")
    @State var showDetailScreen = false
    @State var isTap = false
    
    @State var showUploadView = false
    @State var uploadComplete = false
    @State var flagComplete = false
    
    // To show dynamic...
    @State var activeVote : ActiveVote?
    
    @State var loadView = false
    @State var buttonPressed = [false,false,false]
    @State var buttonSelected = ""
    
    
    @State var voteData:[Double] = []
    @State var voteBarData:[Double] = []
    @State var numVote: Int = 0
    @State var numLike: Int = 0
    
    //    @State var buttonTitle : [String] = ["나는코린이다", "빨간구두가 잘어울린다","돈잘벌꺼같다"]
    @State var numVoteData:[Int] = [0,0,0]
    let bar_graph_ratio =  UIScreen.main.bounds.height < 896.0 ? 4.0 : 3
    @State var ymax : Int = 100
    @State var activeCards = [ActiveVote]()
    // Smooth Hero Effect...
    @Namespace var animation
    @State var tags: [Tag] = []
    
    
    // FLAG
    @State var selectedFlag = ""
    @State var showFlag = false
    @State var flagMessage = false
    //FlowingButton
    @State var showFavoriteView  = false
    
    let haptics = UINotificationFeedbackGenerator()
    
    var tag = ["전체","데일리룩", "데이팅룩" , "핫아이템", "악세사리", "신발", "기타"]
    var body: some View {
        
        ZStack {
//            NavigationView{
//
//
                
            GeometryReader { bounds in
                ScrollView {
                    //
                    //                    SearchBar(searchText: $searchText, isSearching: $isSearching, showResults: $showResults, loadSearch: $loadSearch)
                    //                        .padding(.top, 8)
                    //                        .padding(.bottom, 2)
                    //
                    
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(tag.indices)
                            {
                                categoryButtonView(selectedBtn: tag[$0], searchText: $searchText )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                    .padding(.bottom, 2)
                    
                    LazyVGrid (columns: [GridItem(.adaptive(minimum: bounds.size.width / 3 - 1.2), spacing: 1.2)],
                               spacing: 1) {
                        
                        ForEach(self.observer.activeCards
                                    .filter({"\($0)".contains(searchText.lowercased()) ||
                            searchText == "전체" })
                                
                                
                                , id: \.self){ post in
                            PostCardView(post: post)
                                .matchedGeometryEffect(id: post.id, in: animation)
                                .onTapGesture {
                                    if post.imageLocation != "" {
                                        self.observer.isDeleted(postId: post.id.uuidString, onSuccess: { result in
                                            
                                            if(result){
                                                print("deleted")
                                            }else{
                     
                                                withAnimation(.spring()){
              
                                                    self.voteBarData.removeAll()
                                                    self.voteData.removeAll()
                                                    self.selected = post
                                                    let postID = self.selected.id.uuidString
                                                    
                                                    print(TOKEN)
                                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                        loadChartData(postId: postID)
                                                        self.observer.checkLiked(postId: postID)
                                                    }
                                                    showDetailScreen.toggle()
                                                    showDetailView.toggle()
                                                }
                                                
                                             
                                            }
                                            
                                            
                                        })
                                        
                                    }
                                    
                                }
                            
                        }
                        
                    }.animation(.spring())
                } .padding(.top, 50)
                    .overlay(
                        VStack{
                            HStack{
                                Spacer()
                           
                                Image(APP_LOGO)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 30)
                                    .padding(.trailing, 10).padding(.top, 10)
                                
                                Button {
                                    // Updating Current Type...
                                    withAnimation{
                                        self.observer.activeCards.removeAll()
                                        self.observer.refresh()
                                    }
                                } label: {
                                    
                                    Image(systemName: "arrow.clockwise")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 25).foregroundColor(APP_THEME_COLOR)
                                        .padding(.trailing, 10).padding(.top, 10)
                                }
                            }
                        
                            Spacer()
                        }
                    )

            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    loadSearch = true
                }
            })
            
            if showDetailScreen {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10){
                        
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                            
                            AnimatedImage(url: URL(string: self.selected.imageLocation))
                                .resizable().aspectRatio(contentMode: .fill)
                            //                                    .frame(maxWidth: .infinity,alignment: .leading)
                                .matchedGeometryEffect(id: selected.id, in: animation)
                                .ignoresSafeArea(.container)
                            //                                                    .frame(width: getRect().width , height: getRect().height / 1.5)
                            
                                .frame(maxWidth: .infinity, maxHeight: .infinity).overlay(
                                    
                                    VStack{
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Button {
                                                withAnimation {
                                                    self.showFlag.toggle()
                                                }
                                            } label: {
                                                Image(systemName: "flag.fill" )
                                                    .resizable().foregroundColor(APP_THEME_COLOR)
                                                    .scaledToFit()
                                                    .frame(maxHeight: 25)
                                                
                                            }
                                        }.padding(.trailing)
                                            .padding(.bottom)
                                        
                                    }
                                    
                                )
                            //                                .overlay(
                            //
                            //                                    HeartLike(isTapped: self.$cardViewModel.liked, taps: 3)
                            //                                )
                                .cornerRadius(15)
                            
                            HStack{
                                if !self.voteData.isEmpty{
                                    Button {
                                        
                                        loadView.toggle()
                                        
                                        withAnimation(.spring()){
                                            
                                            showDetailScreen.toggle()
                                            showDetailView.toggle()
                                        }
                                        
                                    } label: {
                                        
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black.opacity(0.5))
                                            .clipShape(Circle())
                                    }
                                }
                                Spacer()
                                
                                Button {
                                    self.observer.liked ? self.observer.disLikePost(postId: selected.id.uuidString) :
                                    self.observer.likePost(post: selected)
                                } label: {
                                    Image(systemName: self.observer.liked ? "heart.fill" : "heart" )
                                        .resizable().foregroundColor(Color("pink"))
                                        .scaledToFit()
                                        .frame(maxHeight: 35)
                                    
                                }
                            }
                            .padding(.top,35)
                            .padding(.horizontal)
                            
                            //
                            
                            
                        }
                        .ignoresSafeArea(.container)
                        .frame(maxHeight: .infinity,   alignment: .leading)
                        // you will get this warning becasue we didnt hide the old view so dont worry about that it will work fine...
                        .previewLayout(.fixed(width: 375, height: 600))
                        //                        .frame(width: getRect().width , height: getRect().height / 1.5)
                        
                        // Detail View....
                        VStack{
                            
                            if(!observer.votedCards.contains(self.selected.id.uuidString)){
                                HStack{
                                    Spacer()
                                    RatingDetailView(card: selected, numLiked: $numLike, numVote : $numVote, hideDetail : true)
                                    
                                    Spacer()
                                    
                                }.padding(.vertical, 10)
                                VStack(alignment: .leading,spacing: 15){
                                    
                                    Text(self.selected.description)
                                        .font(Font.custom(FONT, size: 16))
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    //                                    Spacer(minLength: 0)
                                    Button(action: {
                                        self.haptics.notificationOccurred(.success)
                                        
                                        withAnimation {
                                            self.buttonPressed[0].toggle()
                                            self.sendMessageToDevice(title: ("\(User.currentUser()!.username) 이 투표를 했습니다"),
                                                                     body: "\(self.selected.attrNames[0])", token: self.selected.token)
                                            self.persist()
                                            
                                        }
                                        buttonSelected = self.selected.attrNames[0]
                                        
                                    }, label: {
                                        Text(self.selected.attrNames[0])
                                            .font(Font.custom(FONT, size: 15))
                                            .foregroundColor(.black)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color("BG"))
                                            .animation(.spring())
                                            .cornerRadius(15)
                                            .shadow(color: Color.black.opacity(self.buttonPressed[0] ? 0.1: 0.3), radius: 5, x: 5, y: 5)
                                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                                        
                                        //                                   =
                                    })
                                    
                                    Button(action: {
                                        self.haptics.notificationOccurred(.success)
                                        
                                        withAnimation {
                                            
                                            self.buttonPressed[1].toggle()
                                            self.sendMessageToDevice(title: ("누군가가 투표를 했습니다"),
                                                                     body: "\(self.selected.attrNames[1])", token: self.selected.token)
                                            self.persist()
                                        }
                                        buttonSelected = self.selected.attrNames[1]
                                        
                                    }, label: {
                                        Text(self.selected.attrNames[1])
                                            .foregroundColor(.black)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .font(Font.custom(FONT, size: 15))
                                            .background(Color("BG"))
                                            .animation(.spring())
                                            .cornerRadius(15)
                                            .shadow(color: Color.black.opacity(self.buttonPressed[1] ? 0.1: 0.3), radius: 5, x: 5, y: 5)
                                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                                    })
                                    if(self.selected.attrNames[2] != ""){
                                        Button(action: {
                                            self.haptics.notificationOccurred(.success)
                                            
                                            withAnimation {
                                                self.buttonPressed[2].toggle()
                                                self.sendMessageToDevice(title: ("\(User.currentUser()!.username) 이 투표를 했습니다"),
                                                                         body: "\(self.selected.attrNames[2])", token: self.selected.token)
                                                
                                                self.persist()
                                            }
                                            buttonSelected = self.selected.attrNames[2]
                                            
                                        }, label: {
                                            Text(self.selected.attrNames[2])
                                                .foregroundColor(.black)
                                                .padding()
                                                .font(Font.custom(FONT, size: 15))
                                                .frame(maxWidth: .infinity)
                                                .background(Color("BG"))
                                                .animation(.spring())
                                                .cornerRadius(15)
                                                .shadow(color: Color.black.opacity(self.buttonPressed[2] ? 0.1: 0.3), radius: 5, x: 5, y: 5)
                                                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                                        })
                                    }
                                    
                                    Divider().padding(.horizontal, 15)
                                    
                                    tagview(selected: self.selected)
                                    //                                    Spacer(minLength: 0)
                                    
                                    
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                                .padding(.horizontal)
                                Spacer(minLength: 0)
                                
                            }
                            else{
                                HStack{
                                    Spacer()
                                    RatingDetailView(card: selected, numLiked: $numLike, numVote : $numVote, hideDetail : false)
                                    Spacer()
                                    
                                }.padding(.vertical, 10)
                                VStack(alignment: .leading,spacing: 22){
                                    if !self.voteData.isEmpty {
                                        ChartView_BAR(data: self.$voteData, totalNum: self.$ymax, title: self.selected.description, categories: self.selected.attrNames)
                                            .frame(maxWidth: .infinity,idealHeight: 200)
                                    }
                                    
                                    Divider().padding(.horizontal, 15)
                                    
                                    tagview(selected: self.selected)
                                    
                                    
                                }
                                .offset(y : -20)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                    }
                }
                .background(
                    Color("BG")
                        .ignoresSafeArea()
                )
                //                .ignoresSafeArea(.container)
            }
            
            if(showFlag){
                VStack{
                    
                    Spacer()
                    
                    FlagView(selected: self.$selectedFlag,show: self.$showFlag, flagMessage: self.$flagMessage, flagComplete: $flagComplete, selectedVote: self.selected).offset(y: self.showFlag ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                        .onTapGesture {
                            withAnimation{
                                self.showFlag.toggle()
                            }
                        }
                        .alert(isPresented: $flagMessage) {
                            Alert(
                                title: Text(BLOCKUSER),
                                message: Text(BLOCKMSG),
                                dismissButton: .default(Text(CONFIRM)))
                        }
                    
                }.background(Color(UIColor.label.withAlphaComponent(self.showFlag ? 0.5 : 0)).edgesIgnoringSafeArea(.all))
                    .animation(Animation.spring(response: 0.8, dampingFraction: 0.9, blendDuration: 1.0))
            }
            
            
        }
        .overlay(
            FloatingButton(isTap: $isTap, showUploadView: $showUploadView, showFavoriteView: $showFavoriteView, uploadComplete:$uploadComplete)
            
        )
        .alert(isPresented: $flagComplete) {
            
            return  Alert(
                title: Text(BLOCKUSER),
                message: Text(BLOCKMSG),
                dismissButton: .default(Text(CONFIRM).font(.custom(FONT, size: 17)).foregroundColor(APP_THEME_COLOR), action: {
                    showFlag.toggle()
                    
                    
                    
                }))
            
            
        }
    }
    
    func sendMessageToDevice(title: String, body:String, token:String){
        
        // Simple Logic
        // Using Firebase API to send Push Notification to another device using token
        // Without having server....
        
        // Converting That to URL Request Format....
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else{
            return
        }
        
        let json: [String: Any] = [
            
            "to": token,
            "notification": [
                
                "title": title,
                "body": body
            ],
            "data": [
                
                // Data to be Sent....
                // Dont pass empty or remove the block..
                "app_name": "ganda"
            ]
        ]
        
        
        // Use Your Firebase Server Key !!!
        let serverKey = "AAAA2VHghu0:APA91bFHI37gASbjapAMj0IcoGT5kWYRfiedLMWKHImRpx5wh69eYEira21pjPCjbR2nXTXK_rO64A0EaRsB05IRaM1WUxzvKF47WB6yoGzKm9smlTzvmVy1hG66ujHJtlfgbXzfeVBa"
        
        // URL Request...
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // COnverting json Dict to JSON...
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        // Setting COntent Type and Authoritzation...
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Authorization key will be Your Server Key...
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        // Passing request using URL session...
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            // Else Success
            // CLearing Fields..
            // Or Your Action when message sends...
            print("Success")
            DispatchQueue.main.async {[self] in
                //                title = ""
                //                body = ""
                //                token = ""
            }
        }
        .resume()
    }
    
    func persist() {
        
        self.observer.persist(votePost: selected, buttonPressed: self.buttonPressed)
        buttonPressed = [false,false,false]
        loadChartData(postId: selected.id.uuidString)
        selected.numVote = selected.numVote + 1
    }
    // highlighting answer...
    func color(option: String)->Color{
        if option == buttonSelected{
            return Color("Blue")
        }
        else{
            return Color.gray
        }
    }
    
    func loadChartData(postId : String){
        observer.loadChartData(postId: postId) { voteBarData, numVote , numLiked in
            self.voteData  = voteBarData
            self.numVote = numVote
            self.numLike = numLiked
        }
    }
    
    @ViewBuilder
    func tagview(selected : ActiveVote) -> some View {
        VStack(spacing: 5){
            
            if(selected.tags.isEmpty){
                Text("등록된 태그가 없습니다")
                    .foregroundColor(Color.black).font(Font.custom(FONT, size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Spacer(minLength: 0)
            }else{
                //                HStack{
                //                    Text("태그")
                //                        .foregroundColor(Color.black).font(Font.custom(FONT, size: 15))
                //                        .fontWeight(.bold)
                //                        .foregroundColor(.black)
                //                    Spacer(minLength: 0)
                //                }
                TagView_Card(maxLimit: 100, tags: selected.tags,fontSize: 14)
                    .frame(height: selected.tags.count >= 4 ? 120 : 80)
            }
            
            
            
        }.padding(.leading,12)
        
        
    }
}
//
//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @Binding var showResults: Bool
    @Binding var loadSearch: Bool
    
    var body: some View {
        
        
        HStack (spacing: 0){
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.leading, 24)
            }
            .frame(height: 4)
            .padding()
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
                showResults = true
            })
            .overlay (
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    
                    Button(action: {searchText = ""}, label: {
                        Image(systemName: "xmark.circle.fill")
                            .padding(.vertical)
                            .foregroundColor(.gray)
                            .opacity(isSearching ? 1 : 0)
                    })
                }
                    .padding(.horizontal, 32)
                    .foregroundColor(.gray)
            )
            .animation(loadSearch ? .spring() : .none)
            
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    showResults = false
                    
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                },
                       label: {
                    Text("Cancel")
                        .padding(.trailing)
                    //                        .padding(.leading, 8)
                }
                )
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
                
            }
        }
    }
    

    
}



struct Feed: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    
    
}

let feedData = [
    Feed(title: "car", image: "car"),
    Feed(title: "city", image: "city"),
    Feed(title: "dog", image: "dog"),
    Feed(title: "dog2", image: "dog2"),
    Feed(title: "fall", image: "fall"),
    Feed(title: "fireworks", image: "fireworks"),
    Feed(title: "forest", image: "forest"),
    Feed(title: "office", image: "office"),
    Feed(title: "people", image: "people"),
    Feed(title: "river", image: "river"),
    Feed(title: "skate", image: "skate"),
    Feed(title: "surf", image: "surf"),
    Feed(title: "waterfall", image: "waterfall"),
    Feed(title: "women 2", image: "women 2"),
    Feed(title: "women", image: "women"),
    
]


struct ImagesView: View {
    var feed: Feed = feedData[0]
    
    var body: some View {
        Image(feed.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
