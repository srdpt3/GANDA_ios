//
//  BaseView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/2/22.
//

import SwiftUI

struct BaseView: View {
    
    // Using Image Names as Tab...
    @State var currentTab = "home"
    let haptics = UINotificationFeedbackGenerator()
    @State var showUploadView = false
    @State var uploadComplete : Bool = false
    @State var showDetailView : Bool = false

    // Hiding Native One..
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            
            // Tab View..
            TabView(selection: $currentTab) {
                
//                CardView(showDetailView: $showDetailView, ignoreHeight: <#Binding<Bool>#>)
//                    .modifier(BGModifier())
//                    .tag("home")
                
                MyPageView()
                    .modifier(BGModifier())
                    .tag("graph")
                
                Text("Hot 추천")
                    .modifier(BGModifier())
                    .tag("Reels")
                
                SettingsView()
                    .modifier(BGModifier())
                    .tag("settings")
            }
            
            // Custom Tab Bar...
            HStack(spacing: 40){
                
                // Tab Buttons...
                TabButton(image: "home")
                TabButton(image: "graph")
                
                // Center Add Button...
                Button {
                    self.haptics.notificationOccurred(.success)
                    self.showUploadView.toggle()
                    print("upload")
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(22)
                        .background(
                            
                            Circle()
                                .fill(Color("Blue"))
                            // Shadow...
                                .shadow(color: Color("Blue").opacity(0.15), radius: 5, x: 0, y: 8)
                        )
                }
                // Moving Button little up
                .offset(y: -20)
                .padding(.horizontal,-15)
                
                
                TabButton(image: "Reels")
                TabButton(image: "settings")
            }
            .padding(.top,-10)
            .frame(maxWidth: .infinity)
            .background(
                
                Color("BG")
                    .ignoresSafeArea()
            )
        }
        
        .sheet(isPresented: self.$showUploadView) {
//            UploadView(uploadComplete: self.$uploadComplete)
        
            
            
        }
    }
    
    @ViewBuilder
    func TabButton(image: String)->some View{
        
        Button {
            withAnimation{
                currentTab = image
            }
        } label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(
                    
                    currentTab == image ? Color.black : Color.gray.opacity(0.8)
                )
        }
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}

// BG Modifier...
struct BGModifier: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BG").ignoresSafeArea())
    }
}
