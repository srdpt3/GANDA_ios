//
//  HomeView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/7/22.
//


import SwiftUI

struct Home: View {
    @Binding var selectedTab: String
    @Binding var showMenu : Bool
    @Binding var showDetailView : Bool

    
    
    
    // Hiding Tab Bar...
    init(selectedTab: Binding<String>, showMenu: Binding<Bool>, showDetailView: Binding<Bool>) {
        self._selectedTab = selectedTab
        self._showMenu = showMenu
        self._showDetailView  = showDetailView
        //        self._showMenu = false
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        // Tab View With Tabs...
        TabView(selection: $selectedTab){
            
            // Views...
            CardView(showDetailView : $showDetailView)
                .tag("둘러보기")
              
            
            MyPageView().tag("마이페이지")
            ReelsView()
                .tag("릴스")
            
            
            SettingsView()
                .tag("앱정보")
     
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SettingView: View {
    var body: some View {
        Text("Setting View")
    }
    
}
