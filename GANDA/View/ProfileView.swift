//
//  ProfileView.swift
//  GANDA
//
//  Created by Dustin yang on 1/16/22.
//


import SwiftUI
import SDWebImageSwiftUI

struct ProfileView : View {

    @Binding  var profile_show: Bool
    
  var body : some View{
            
            ZStack{
                
                Image("bg").resizable().edgesIgnoringSafeArea(.all)
                
                VStack{
                    
//                    HStack{
//
//                        Button(action: {
//
//                        }) {
//
//                            Image("menu").renderingMode(.original).resizable().frame(width: 20, height: 20)
//                        }
//
//                        Spacer()
//
//                        Button(action: {
//
//                        }) {
//
//                            Image("close").renderingMode(.original).resizable().frame(width: 20, height: 20)
//                        }
//                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .top) {
                        
                        VStack{
                            
                            HStack{
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("권기덕").font(.title)
                                    Text("25")
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 8){
                                    
                                    Image("map").resizable().frame(width: 15, height: 20)
                                    
                                    Text("대한민국")
                                    
                                }.padding(8)
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(10)
                            }.padding(.top,35)
                            
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s").padding(.top)
                            
                        }.padding()
                        .background(Blurview())
                        .clipShape(BottomShape())
                        .cornerRadius(25)
                        
                        ZStack{
                            
                            Button(action: {
                                
                            }) {
                                
                                Image("play").renderingMode(.original).resizable()
                                .frame(width: 20, height: 20)
                                .padding(20)
                                .background(Color.white)
                                .clipShape(Circle())
                            }
                            
                            Circle().stroke(Color.yellow, lineWidth: 5).frame(width: 70, height: 70)
                            
                        }.offset(y: -35)
                        
                        HStack{
                            
                            Button(action: {
                                
                            }) {
                                
                                Image("heart").renderingMode(.original).resizable()
                                    .frame(width: 25, height: 20)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                
                                Image("smile").renderingMode(.original).resizable()
                                    .frame(width: 25, height: 25)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            }.offset(y: -25)
                            .padding(.horizontal,35)
                    }
                    
                }.padding()
            }        .overlay(
                
                // Close Button...
                Button {
                    // Toggling Menu Option...
                    withAnimation(.spring()){
                        profile_show.toggle()
                    }
                } label: {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                // Hidinig When Menu is Visible...
//                .opacity(profile_show ? 1 : 0)
                .padding()
                .padding(.top)
                
                ,alignment: .topTrailing
            )
        }
        
    
}
struct BottomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addArc(center: CGPoint(x: rect.width / 2, y: 0), radius: 42, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: false)
            
        }
    }
}

struct Blurview : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Blurview>) -> UIVisualEffectView {
        
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Blurview>) {
        
        
    }
}
