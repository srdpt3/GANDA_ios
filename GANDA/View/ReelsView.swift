//
//  ReelsView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/30/21.
//


import SwiftUI
import AVKit

struct ReelsView: View {
    
    @State var currentReel = ""
    
    // Extracting Avplayer from media File...
    @State var reels = MediaFileJSON.map { item -> Reel in
        
        let url = Bundle.main.path(forResource: item.url, ofType: "MP4") ?? ""
        
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        
        return Reel(player: player, mediaFile: item)
    }
    
    
    var body: some View {
        
        // Setting Width and height for rotated view....
        GeometryReader{proxy in
            
            let size = proxy.size
            
            // Vertical Page Tab VIew....
            TabView(selection: $currentReel){
                
                ForEach($reels){$reel in
                    
                    ReelsPlayer(reel: $reel, currentReel: $currentReel)
                    // setting width...
                    .frame(width: size.width)
                    // Rotating Content...
                    .rotationEffect(.init(degrees: -90))
//                    .ignoresSafeArea(.all, edges: [.top])
                    .ignoresSafeArea()
                   

                    .tag(reel.id)
                }
            }
            // Rotating View....
            .rotationEffect(.init(degrees: 90))
            // Since view is rotated setting height as width...
            .frame(width: size.height + 20)
            .tabViewStyle(.page(indexDisplayMode: .never))
            // setting max width...
            .frame(width: size.width)
        }
        .ignoresSafeArea()
        .background(Color("BG"))
        // setting intial reel...
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReelsPlayer: View{
    
    @Binding var reel: Reel
    
    @Binding var currentReel: String
    
    // Expading title if its clicked...
    @State var showMore = false
    
    @State var isMuted = false
    @State var volumeAnimation = false
    
    var body: some View{
        
        ZStack{
            
            // safe Check...
            if let player = reel.player{
                
                CustomVideoPlayer(player: player)
                
                // Playing Video Based on Offset...
                
                GeometryReader{proxy -> Color in
                    
                    let minY = proxy.frame(in: .global).minY
                    
                    let size = proxy.size
                    
                    DispatchQueue.main.async {
                        
                        // since we have many cards and offset goes beyond
                        // so it starts playing the below videos...
                        // to avoid this checking the current one with current reel id.....
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currentReel == reel.id{
                            
                            player.play()
                        }
                        else{
                            player.pause()
                        }
                    }
                    
                    return Color.clear
                }
                
                
                // Volume COntrol....
                // allowing control for set of area...
                // its your wish...
                Color.black
                    .opacity(0.01)
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        if volumeAnimation{
                            return
                        }
                        
                        isMuted.toggle()
                        // Muting player...
                        player.isMuted = isMuted
                        withAnimation{volumeAnimation.toggle()}
                        
                        // Closing animation after 0.8 sec...
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            
                            withAnimation{volumeAnimation.toggle()}
                        }
                    }
                
                // Dimming background when showing more content...
                Color.black.opacity(showMore ? 0.35 : 0)
                    .onTapGesture {
                        // closing it...
                        withAnimation{showMore.toggle()}
                    }
                
                VStack{
                    
                    HStack(alignment: .bottom){
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            HStack(spacing: 15){
                                
//                                Image("profile")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 35, height: 35)
//                                    .clipShape(Circle())
//
//                                Text("")
//                                    .font(.callout.bold())
//
//                                Button {
//
//                                } label: {
//                                    Text("Follow")
//                                        .font(.caption.bold())
//                                }

                            }
                            
                            // Title Custom View...
                            
                            ZStack{
                                
                                if showMore{
                                    
                                    ScrollView(.vertical, showsIndicators: false) {
                                        
                                        // your extra text...
                                        Text(reel.mediaFile.title + sampleText)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    .frame(height: 120)
                                    .onTapGesture {
                                        withAnimation{showMore.toggle()}
                                    }
                                }
                                else{
                                    
                                    Button {
                                        
                                        withAnimation{showMore.toggle()}
                                        
                                    } label: {
                                        
                                        HStack{
                                            
                                            Text(reel.mediaFile.title)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .lineLimit(1)
                                            
                                            Text("더보기")
                                                .font(.callout.bold())
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.top,6)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                }
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        // List of Buttons....
                        
                        ActionButtons(reel: reel)
                    }
                    
                    // Music View...
                    HStack{
                        
                        Text("릴스 테스팅")
                            .font(.caption)
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 20)
                        
//                        Image("")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 30, height: 30)
//                            .cornerRadius(6)
//                            .background(
//
//                                RoundedRectangle(cornerRadius: 6)
//                                    .stroke(Color.white,lineWidth: 3)
//                            )
//                            .offset(x: -5)
                    }
                    .padding(.top,10)
                }
                .padding(.horizontal)
                .padding(.bottom,20)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(.secondary)
                    .clipShape(Circle())
                    .foregroundStyle(.black)
                    .opacity(volumeAnimation ? 1 : 0)
            }
        }
        .onDisappear {
            reel.player?.isMuted = true
            reel.player?.seek(to: .zero)
            reel.player?.pause()
        }
    }
}

struct ActionButtons: View{
    var reel: Reel
    
    var body: some View{
        
        VStack(spacing: 25){
            
//            Button {
//
//            } label: {
//                VStack(spacing: 10){
//
//                    Image(systemName: "suit.heart")
//                        .font(.title)
//                }
//            }
//
//            Button {
//
//            } label: {
//                VStack(spacing: 10){
//
//                    Image(systemName: "bubble.right")
//                        .font(.title)
//
//                    Text("120")
//                        .font(.caption.bold())
//                }
//            }
//
//            Button {
//
//            } label: {
//                VStack(spacing: 10){
//
//                    Image(systemName: "paperplane")
//                        .font(.title)
//                }
//            }
//
//            Button {
//
//            } label: {
//                Image("menu")
//                    .resizable()
//                    .renderingMode(.template)
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20, height: 20)
//                // rotating...
//                    .rotationEffect(.init(degrees: 90))
//            }


        }
    }
}


let sampleText = "테스트 테스트 테스트."
