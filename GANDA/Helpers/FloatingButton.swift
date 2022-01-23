//
//  FloatingButton.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/8/22.
//

import SwiftUI

struct FloatingButton: View {
    
    @Binding var isTap : Bool
    @Binding var showUploadView : Bool
    @Binding var showFavoriteView : Bool
    
    @Binding var uploadComplete : Bool
    let haptics = UINotificationFeedbackGenerator()
    
    var body: some View {
        VStack{
            Spacer()
            
            HStack{
                Spacer()
                ZStack{
                    
                    //                    Button(action: {
                    //                        //
                    ////                        showUploadView.toggle()
                    //                        showFavoriteView.toggle()
                    //                        isTap.toggle()
                    //                    }, label: {
                    //                        Image(systemName: "heart.fill")
                    //                            .resizable()
                    //                            .renderingMode(.template)
                    //                            .frame(width: 28, height: 28)
                    //                            .padding()
                    //                    })
                    //                        .background(GRADIENT_COLORS[3])
                    //                        .foregroundColor(.white)
                    //                        .clipShape(Circle())
                    //                    //                                            .padding()
                    //                        .scaleEffect(isTap ? 1.1 : 1)
                    //                        .offset(x: isTap ? -0  : 0, y: isTap ? -180:0 )
                    //                        .opacity(isTap ? 1 : 0)
                    //                        .fullScreenCover(isPresented: $showUploadView) {
                    //                            UploadPhotoView(uploadComplete: self.$uploadComplete, showUploadView: self.$showUploadView)
                    //                        }
                    //
                    //                    Button(action: {
                    //                        showUploadView.toggle()
                    //                        isTap.toggle()
                    //
                    //                    }, label: {
                    //                        Image(systemName: "photo.fill")
                    //                            .resizable()
                    //                            .renderingMode(.template)
                    //                            .frame(width: 28, height: 28)
                    //                            .padding()
                    //                    })
                    //                        .background(GRADIENT_COLORS[3])
                    //                        .foregroundColor(.white)
                    //                        .clipShape(Circle())
                    //                        .offset(x: isTap ? -0  : 0, y: isTap ? -90 :0 )
                    //                        .scaleEffect(isTap ? 1.1 : 1)
                    //                        .opacity(isTap ? 1 : 0)
                    //
                    //                        .fullScreenCover(isPresented: $showUploadView) {
                    //                            UploadView(uploadComplete: self.$uploadComplete, showUploadView: self.$showUploadView)
                    //                        }
                    
                    Button(action: {
                        self.haptics.notificationOccurred(.success)
                        showUploadView.toggle()
                        isTap.toggle()
                    }, label: {
                        Image(systemName:"plus")
                            .resizable().scaledToFit()
                        //                            .renderingMode(.template)
                            .frame(width: 28, height: 25)
                            .padding()
                    })
                        .background(GRADIENT_COLORS[3])
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0 ))
                .scaleEffect(isTap ? 1.1 : 1)
                //                                        .offset(x: isTap ? -0  : 0, y: isTap ? -180:0 )
                //                                        .opacity(isTap ? 1 : 0)
                .fullScreenCover(isPresented: $showUploadView) {
                    UploadPhotoView(uploadComplete: self.$uploadComplete, showUploadView: self.$showUploadView)
                }
                
            }
            .padding([.bottom, .trailing],10)
        }
        
    }
}

//struct FloatingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatingButton()
//    }
//}
