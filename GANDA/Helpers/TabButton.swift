//
//  TabButton.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/7/22.
//


import SwiftUI


struct TabButton: View {
    var image: String
    var title: String
    
    // Selected Tab...
    @Binding var selectedTab: String
    @Binding var showmenu: Bool

    // For Hero Animation Slide...
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring(response: 0.7, dampingFraction: 1.1, blendDuration: 0)){

                selectedTab = title
                showmenu.toggle()

                
                
            }

        }, label: {
            
            HStack(spacing : 15){
                
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                    
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? APP_THEME_COLOR : .white)
            .padding(.vertical,12)
            .padding(.horizontal,10)
            // Max Frame..
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background(
            
                // hero Animation...
                ZStack{
                    
                    if selectedTab == title{
                        Color.white
                            .opacity(selectedTab == title ? 1 : 0)
                            .clipShape(CustomCorners(corners: [.topRight,.bottomRight], radius: 12))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
        })
      
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
