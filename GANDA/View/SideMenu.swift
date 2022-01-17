//
//  SideMenu.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/30/21.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SDWebImageSwiftUI


struct SideMenu: View {
    @AppStorage("isLogged") var log_Status = false
    @EnvironmentObject var observer : Observer

    @Binding var selectedTab: String
    @Binding var showMenu: Bool
    @State var profile_show : Bool = false

    @Namespace var animation

//    @State var user : User
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            
            // Profile Pic...
            
            if(User.currentUser() != nil &&  User.currentUser()!.profileImageUrl != ""){
                AnimatedImage(url: URL(string: User.currentUser()!.profileImageUrl)).resizable()
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(35)
                    .clipShape(Circle())
                // Padding top for Top Close Button...
                    .padding(.top,50)
            }
            else{
                Image(APP_LOGO_SMALL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(35)
                    .clipShape(Circle())
                // Padding top for Top Close Button...
                    .padding(.top,50)
            }
//            Image(APP_LOGO_SMALL)

            
            VStack(alignment: .leading, spacing: 6, content: {
                if(User.currentUser() != nil){
                    Text("Hello \(User.currentUser()!.username)")
    //                    .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
       

                Button(action: {
                    withAnimation{
                        self.profile_show.toggle()
                    }
                 
                    
                    
                }, label: {
                    Text(PROFILE_VIEW)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                })
            })
            
            // tab Buttons...
            VStack(alignment: .leading,spacing: 10){
                
//                TabButton(image: "house", title: "Home", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "photo.fill.on.rectangle.fill", title: "둘러보기", selectedTab: $selectedTab, showmenu: $showMenu, animation: animation)
            
                TabButton(image: "chart.bar.doc.horizontal.fill", title: "마이페이지", selectedTab: $selectedTab, showmenu: $showMenu, animation: animation)
                
                TabButton(image: "video.square.fill", title: "릴스", selectedTab: $selectedTab, showmenu: $showMenu, animation: animation)
                
                TabButton(image: "gearshape.fill", title: "앱정보", selectedTab: $selectedTab, showmenu: $showMenu, animation: animation)
//
//                TabButton(image: "questionmark.circle", title: "Help", selectedTab: $selectedTab, showmenu: $showMenu, animation: animation)


            }
            .padding(.leading,-15)
            .padding(.top,30)
            

            
            // Sign Out Button...
            VStack(alignment: .leading, spacing: 6, content: {
                
                
                Button(action: {
//                    homeData.signOut()
                    
                    GIDSignIn.sharedInstance.signOut()
                    try? Auth.auth().signOut()
                    
                    // Setting Back View To Login...
                    withAnimation(.easeInOut){
                        observer.resetDefaults()

                        log_Status = false
                        
                    }
                    
                    
                }, label: {
                    
                    HStack(spacing : 15){
                        
                        Image(systemName: "rectangle.righthalf.inset.fill.arrow.right")
                            .font(.title2)
                            .frame(width: 30)
                            
                        Text(LOGOUT)
                            .fontWeight(.semibold)
                    }  .foregroundColor(.white)
                    .padding(.vertical,12)
                    .padding(.horizontal,10)
                    // Max Frame..
                    .frame(maxWidth: getRect().width - 170, alignment: .leading)

                  
                })
                .padding(.leading,-15)
//.padding(.leading,-15)
//                TabButton(image: "rectangle.righthalf.inset.fill.arrow.right", title: "Log out", selectedTab: .constant(""), animation: animation)
//                    .padding(.leading,-15)
                 Spacer()
                
                
                Text(VERSION + ": " + APP_VERSION + " 데모")
//                    .font(.caption)
                    .font(Font.custom(FONT, size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0.6)
            })
            
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .sheet(isPresented: self.$profile_show) {
       
                ProfileView(profile_show: self.$profile_show).animation(.spring())

           
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



