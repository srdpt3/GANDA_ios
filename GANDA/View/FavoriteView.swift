//
//  FavoriteView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/9/22.
//


import SwiftUI


struct FavoriteView : View {
    @Binding var showFavoriteView : Bool
    @Binding var isTap : Bool
    @State var selected : Int = 0
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                Text(INFO_FAVORITE).font(.custom(FONT, size: CGFloat(BUTTON_TITLE_FONT_SIZE))).foregroundColor(APP_THEME_COLOR)
                Spacer()
                Button(action: {
                    // ACTION
                    withAnimation {
//                        print("asdfasdf")
                        showFavoriteView.toggle()
//                        isTap.toggle()
                    }
                    
                    
                    //                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.white)
                        .shadow(radius: 10)
                        .opacity( 1 )
                        .scaleEffect(1.7 , anchor: .center).zIndex(1)
                })
//                    .zIndex(1)
            }
            //            .padding(.trailing, 15)
            Divider()
            Text("17개 사진을 좋아합니다").font(.custom(FONT, size: CGFloat(15))).foregroundColor(COLOR_LIGHT_GRAY)

            
            TabView(selection: $selected){
                
                // Images...
                ForEach(1...7,id: \.self){index in
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                        
                        // Geometry Reader For Parallax Effect...
                        
                        GeometryReader{reader in
                            
                            Image("post\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                // moving view in opposite side
                                // when user starts to swipe...
                                // this will create parallax Effect...
                                .offset(x: -reader.frame(in: .global).minX)
                                .frame(width: width, height: height / 2.2)
                                .onTapGesture {
                                            print("tab")
                                }
                                
                        }
                        .frame(height: height / 2.2)
                        .cornerRadius(15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(15)
                        // shadow...
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5)
                        // decreasing width by padding...
                        // so outer view only decreased..
                        // inner image will be full width....
                        
                        // Bottom Image...
                        
                        Image("Pic2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .padding(5)
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(x: -15, y: 25)
                    })
                    .padding(.horizontal,25)
                    
                }
            }
            .offset(y : -60)
            // page Tab View...
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
        .padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)!)
            .background(APP_BACKGROUND)
            .cornerRadius(30)
    }
}



