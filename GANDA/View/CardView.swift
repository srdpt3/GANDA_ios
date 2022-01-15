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

    
    @Binding var showDetailView : Bool
    
    @State var selected  = ActiveVote(attr1: 0, attr2: 0, attr3: 0, attr4: 0, attr5: 0, attrNames: [], tags: [],numVote: 0, createdDate: 0.0, lastModifiedDate: 0.0, userId: "", email: "", imageLocation: "", username: "", sex: "", location: "", description: "", token: "")
    @State var show = false
    @State var isTap = false
    
    @State var showUploadView = false
    @State var uploadComplete = false
    
    // To show dynamic...
    @State var activeVote : ActiveVote?
    @State var columns: Int = 3
    @State var loadView = false
    @State var buttonPressed = [false,false,false]
    @State var buttonSelected = ""
    
    
    @State var voteData:[Double] = []
    @State var voteBarData:[Double] = []
    
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
    
    @StateObject private var cardViewModel = CardViewModel()
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            NavigationView{
                
                if !self.cardViewModel.activeCards.isEmpty {
                    
                    StaggeredGrid(columns: columns, list: self.cardViewModel.activeCards, content: { post in
                        
                        // Post Card View...
                        PostCardView(post: post)
                            .matchedGeometryEffect(id: post.id, in: animation)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    
                                    if post.imageLocation != "" {
                                        self.voteBarData.removeAll()
                                       self.voteData.removeAll()
                                        self.selected = post
                                        loadChartData(postId: self.selected.id.uuidString)
                                        
                                        show.toggle()
                                        showDetailView.toggle()
                                        print(TOKEN)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            
                                        }
                                    }
                                    
                                }
                            }.onLongPressGesture {
                                withAnimation(.spring()){
                                    
                                    showFlag.toggle()
                                    self.selected = post
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    }
                                }
                                
                                
                            }
                    })
                        .padding(.horizontal)
                        .padding(.top, -50)
                        .toolbar {
                            
                            ToolbarItem(placement: .navigationBarLeading) {
                                
                                Image(APP_LOGO)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                                    .padding(.leading,UIScreen.main.bounds.width / 4)
                                
                                
                            }
                            
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                
                                Button {
                                    columns = min(columns + 1, 4)
                                    
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .background(
                                            ZStack{
                                                Color("Blue")
                                            }
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        )
                                    
                                }
                                
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                
                                Button {
                                    columns = max(columns - 1, 1)
                                } label: {
                                    Image(systemName: "minus")
                                        .foregroundColor(.white)
                                        .background(
                                            ZStack{
                                                Color("Blue")
                                            }
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        )
                                }
                            }
                        }.animation(.easeInOut, value: columns)
                        .background(
                            Color("BG")
                                .ignoresSafeArea()
                        )
                    
                    
                    
                }
                else{
                    LottieView(filename: "loading").frame(width: 220, height: 220)
                }
            }
            .overlay(
                FloatingButton(isTap: $isTap, showUploadView: $showUploadView, showFavoriteView: $showFavoriteView, uploadComplete:$uploadComplete)
                
            )
            //            .zIndex(1)
            
            if show{
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10){
                        
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                            
                            AnimatedImage(url: URL(string: self.selected.imageLocation))
                                .resizable().aspectRatio(contentMode: .fill)
                            //                                    .frame(maxWidth: .infinity,alignment: .leading)
                                .matchedGeometryEffect(id: selected.id, in: animation)
                                .ignoresSafeArea(.container)
                            
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            
                            HStack{
                                if !self.voteData.isEmpty{
                                    Button {
                                        
                                        loadView.toggle()
                                        
                                        withAnimation(.spring()){
                                            
                                            show.toggle()
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
                                    
                                    
                                } label: {
                                    
                                    
                                    Image("empty-heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 30)
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
                            HStack{
                                Spacer()
                                RatingDetailView(card: selected)
                                Spacer()
                                
                            }
                            if(!observer.votedCards.contains(self.selected.id.uuidString)){
                                
                                VStack(alignment: .leading,spacing: 15){
                                    
                                    Text(self.selected.description)
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    Spacer(minLength: 0)
                                    Button(action: {
                                        withAnimation {
                                            self.buttonPressed[0].toggle()
                                            self.sendMessageToDevice(title: ("\(User.currentUser()!.username) 이 투표를 했습니다"),
                                                                     body: "\(self.selected.attrNames[0])", token: self.selected.token)
                                            self.persist()
                                        }
                                        buttonSelected = self.selected.attrNames[0]
                                        
                                    }, label: {
                                        Text(self.selected.attrNames[0])
                                            .foregroundColor(.black)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(color(option: self.selected.attrNames[0]),lineWidth: 2)
                                            )
                                    })
                                    
                                    Button(action: {
                                        
                                        withAnimation {
                                            self.buttonPressed[1].toggle()
                                            self.sendMessageToDevice(title: ("\(User.currentUser()!.username) 이 투표를 했습니다"),
                                                                     body: "\(self.selected.attrNames[1])", token: self.selected.token)
                                            self.persist()
                                        }
                                        buttonSelected = self.selected.attrNames[1]
                                        
                                    }, label: {
                                        Text(self.selected.attrNames[1])
                                            .foregroundColor(.black)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(color(option: self.selected.attrNames[1]),lineWidth: 2)
                                            )
                                    })
                                    
                                    Button(action: {
                                        
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
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(color(option: self.selected.attrNames[2]),lineWidth: 2)
                                            )
                                    })
                                    Spacer(minLength: 0)
                                    
                                    
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                                .padding(.horizontal)
                                
                                
                            }
                            else{
                                
                                VStack(alignment: .leading,spacing: 22){
                                    if !self.voteData.isEmpty {
                                        ChartView_BAR(data: self.$voteData, numVote: self.$numVoteData, totalNum: self.$ymax, title: self.selected.description, categories: self.selected.attrNames)
                                            .frame(maxWidth: .infinity,idealHeight: 200)
                                    }
                                    
                                    //                                  x          .padding()
                                    //                                            .background(Color.white)
                                    //                                            .cornerRadius(25)
                                    //                                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                                    //                                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                                    //                                            .padding(.horizontal)
                                    //                                            .padding(.top)
                                    Divider().padding(.horizontal, 15)
                                    VStack(spacing: 5){
                                        HStack{
                                            Text("사진 태그들")
                                                .foregroundColor(Color("Gray")).font(Font.custom(FONT, size: 15))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Spacer(minLength: 0)
                                        }
                                        TagView_Card(maxLimit: 100, tags: self.selected.tags,fontSize: 16)
                                        // Default Height...
                                            .frame(height: 100)
                                        
                                        //                                            ParallexView().padding(.leading,15).z
                                        
                                    }.padding(.leading,15)
                                    
                                }
                                .offset(y : -20)
                                .padding()
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
        .onAppear {
            
        }
        //        .zIndex(1)
        
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
        observer.loadChartData(postId: postId) { voteBarData, numVote in
            self.voteData  = voteBarData
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
