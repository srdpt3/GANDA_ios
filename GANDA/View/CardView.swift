//
//  CardView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/31/21.
//
import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    
    @EnvironmentObject var observer : Observer
    
    let icon_size =  UIScreen.main.bounds.height <  926.0 ? 25 : 30
    let logo_size =  UIScreen.main.bounds.height < 926.0 ? 30 : 35
    
    @Binding var showDetailView : Bool
    
    @State var selected  = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [],numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "", numLiked: 0)
    @State var showDetailScreen = false
    @State var isTap = false
    
    @State var showUploadView = false
    @State var uploadComplete = false
    
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
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            NavigationView{
                
                ScrollRefreshable(title: "사진 새로고침", tintColor: APP_THEME_COLOR, content: {
                    
                    if !self.observer.activeCards.isEmpty {
                        
                        StaggeredGrid(columns: self.observer.columns, list: self.observer.activeCards, content: { post in
                            
                            // Post Card View...
                            PostCardView(post: post)
                                .matchedGeometryEffect(id: post.id, in: animation)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        
                                        if post.imageLocation != "" {
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
                                }.onLongPressGesture {
                                    withAnimation(.spring()){
                                        if post.imageLocation != "" {
                                            self.selected = post
                                            
                                            showFlag.toggle()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            }
                                        }
                                        
                                        
                                    }
                                }
                        })
                            .padding(.horizontal)
                            .padding(.top, -50)
                            .toolbar {
                                
                                ToolbarItem(placement: .navigationBarLeading) {
                                    
                                    Image("logo_main_blue")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: CGFloat(logo_size))
                                        .foregroundColor(Color("Gray"))
                                        .padding(.leading,50)
                                    
                                    
                                }
                                
                                
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    
                                    Button(action: {
                                        // ACTION
                                        //        playSound(sound: "sound-click", type: "mp3")
                                        
                                        self.haptics.notificationOccurred(.success)
                                        
                                    }) {
                                        Image(systemName:  "bell.fill")
                                            .foregroundColor(APP_THEME_COLOR)
                                            .frame(width: CGFloat(icon_size), height: CGFloat(icon_size))
                                    }
                                    
                                }
                                
                                
                                
                                
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    
                                    Button {
                                        self.haptics.notificationOccurred(.success)
                                        self.observer.columns = min(self.observer.columns + 1, 4)
                                        
                                    } label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .background(
                                                ZStack{
                                                    APP_THEME_COLOR
                                                }
                                                    .frame(width: CGFloat(icon_size), height: CGFloat(icon_size))
                                                    .clipShape(Circle())
                                            )
                                        
                                    }
                                    
                                }
                                
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    
                                    Button {
                                        self.haptics.notificationOccurred(.success)
                                        self.observer.columns = max(self.observer.columns - 1, 1)
                                    } label: {
                                        Image(systemName: "minus")
                                            .foregroundColor(.white)
                                            .background(
                                                ZStack{
                                                    APP_THEME_COLOR
                                                }
                                                    .frame(width: CGFloat(icon_size), height: CGFloat(icon_size))
                                                    .clipShape(Circle())
                                            )
                                    }
                                }
                            }.animation(.easeInOut, value: self.observer.columns)
                            .background(
                                Color("BG")
                                    .ignoresSafeArea()
                            )
                        
                        
                        
                    }
                    else{
                        
                        //                        LottieView(filename: "loading").frame(width: 200, height: 200).offset(y:20)
                    }
                }){
                    
                    // Refresh COntent....
                    // Await Task....
                    
                    self.observer.refresh()
                    // Since iOS 15 will show indicator until await task finishes...
                    await Task.sleep(1_500_000_000)
                }
                
                
            }
            .overlay(
                FloatingButton(isTap: $isTap, showUploadView: $showUploadView, showFavoriteView: $showFavoriteView, uploadComplete:$uploadComplete)
                
            )
            //            .zIndex(1)
            
            if showDetailScreen {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10){
                        
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                            
                            AnimatedImage(url: URL(string: self.selected.imageLocation))
                                .resizable().aspectRatio(contentMode: .fill)
                            //                                    .frame(maxWidth: .infinity,alignment: .leading)
                                .matchedGeometryEffect(id: selected.id, in: animation)
                                .ignoresSafeArea(.container)
                            
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                                    Image(self.observer.liked ? "full-heart" : "empty-heart" )
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 35)
                                        .clipShape(Circle())
                                    
                                }
                            }
                            .padding(.top,35)
                            .padding(.horizontal)
                            
                            
                        }
                        .ignoresSafeArea(.container)
                        .frame(maxHeight: .infinity,   alignment: .leading)
                        // you will get this warning becasue we didnt hide the old view so dont worry about that it will work fine...
                        .previewLayout(.fixed(width: 375, height: 500))
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
                                    
                                    
                                    Spacer(minLength: 0)
                                    
                                    
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
                                    VStack(spacing: 5){
                                        HStack{
                                            Text("사진 태그들 - Long press to search (Test)")
                                                .foregroundColor(Color.black).font(Font.custom(FONT, size: 15))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Spacer(minLength: 0)
                                        }
                                        TagView_Card(maxLimit: 100, tags: self.selected.tags,fontSize: 16)
                                        // Default Height...
                                            .frame(height: 100)
                                        
                                        //                                            ParallexView().padding(.leading,15).z
                                        
                                    }.padding(.leading,12)
                                    
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
                .ignoresSafeArea(.container)
            }
            
            
            if(showFavoriteView){
                VStack{
                    
                    Spacer()
                    
                    FavoriteView(showFavoriteView: self.$showFavoriteView, isTap: self.$isTap).offset(y: self.showFavoriteView ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 130 : UIScreen.main.bounds.height)
                        .onTapGesture {
                            withAnimation{
                                self.showFavoriteView.toggle()
                                
                            }
                        }
                    //                        .animation(Animation.spring(response: 0.8, dampingFraction: 1.0, blendDuration: 1.0))
                    
                    //
                    
                }.background(Color(UIColor.label.withAlphaComponent(self.showFavoriteView ? 0.7 : 0)).edgesIgnoringSafeArea(.all))
                //                    .animation(Animation.spring(response: 0.8, dampingFraction: 0.9, blendDuration: 1.0))
                
                
            }
            
            
            
            if(showFlag){
                VStack{
                    
                    Spacer()
                    
                    FlagView(selected: self.$selectedFlag,show: self.$showFlag, flagMessage: self.$flagMessage).offset(y: self.showFlag ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
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
    
    
    struct HeartLike: View{
        
        // Animation Properites....
        @Binding var isTapped: Bool
        
        @State var startAnimation = false
        @State var bgAniamtion = false
        // Resetting Bg....
        @State var resetBG = false
        @State var fireworkAnimation = false
        
        @State var animationEnded = false
        
        // To Avoid Taps during Animation...
        @State var tapComplete = false
        
        // Setting How Many taps...
        var taps: Int = 2
        
        var body: some View{
            
            // Heart Like Animation....
            Image(systemName: resetBG ? "suit.heart.fill" : "suit.heart")
                .font(.system(size: 45))
                .foregroundColor(resetBG ? .red : .gray)
            // Scaling...
                .scaleEffect(startAnimation && !resetBG ? 0 : 1)
                .opacity(startAnimation && !animationEnded ? 1 : 0)
            // BG...
                .background(
                    
                    ZStack{
                        
                        CustomShape(radius: resetBG ? 29 : 0)
                            .fill(Color.purple)
                            .clipShape(Circle())
                        // Fixed Size...
                            .frame(width: 50, height: 50)
                            .scaleEffect(bgAniamtion ? 2.2 : 0)
                        
                        ZStack{
                            
                            // random Colors..
                            let colors: [Color] = [.red,.purple,.green,.yellow,.pink]
                            
                            ForEach(1...6,id: \.self){index in
                                
                                Circle()
                                    .fill(colors.randomElement()!)
                                    .frame(width: 12, height: 12)
                                    .offset(x: fireworkAnimation ? 80 : 40)
                                    .rotationEffect(.init(degrees: Double(index) * 60))
                            }
                            
                            ForEach(1...6,id: \.self){index in
                                
                                Circle()
                                    .fill(colors.randomElement()!)
                                    .frame(width: 8, height: 8)
                                    .offset(x: fireworkAnimation ? 64 : 24)
                                    .rotationEffect(.init(degrees: Double(index) * 60))
                                    .rotationEffect(.init(degrees: -45))
                            }
                        }
                        .opacity(resetBG ? 1 : 0)
                        .opacity(animationEnded ? 0 : 1)
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .contentShape(Rectangle())
                .onTapGesture(count: taps){
                    
                    if tapComplete{
                        
                        updateFields(value: false)
                        // resettin back...
                        return
                    }
                    
                    
                    if startAnimation{
                        return
                    }
                    
                    isTapped = true
                    
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                        
                        startAnimation = true
                    }
                    
                    // Sequnce Animation...
                    // Chain Animation...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)){
                            
                            bgAniamtion = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                
                                resetBG = true
                            }
                            
                            // Fireworks...
                            withAnimation(.spring()){
                                fireworkAnimation = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                
                                withAnimation(.easeOut(duration: 0.4)){
                                    animationEnded = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    tapComplete = true
                                }
                            }
                        }
                    }
                }
                .onChange(of: isTapped) { newValue in
                    if isTapped && !startAnimation{
                        // setting everything to true...
                        updateFields(value: true)
                    }
                    
                    if !isTapped{
                        updateFields(value: false)
                    }
                }
        }
        
        func updateFields(value: Bool){
            
            startAnimation = value
            bgAniamtion = value
            resetBG = value
            fireworkAnimation = value
            animationEnded = value
            tapComplete = value
            isTapped = value
        }
    }
}

struct CustomShape: Shape{
    
    // value...
    var radius: CGFloat
    
    // animating Path...
    var animatableData: CGFloat{
        get{return radius}
        set{radius = newValue}
    }
    
    // Animatable path wont work on previews....
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            // adding Center Circle....
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: center)
            path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
        }
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
// since we declared T as Identifiable...
// so we need to pass Idenfiable conform collection/Array...
