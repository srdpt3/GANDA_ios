//
//  LoadingView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/7/22.
//

import SwiftUI

struct LoadingView: View {
    @State var animate = false
    var body: some View {
    
        VStack{
            Circle().trim(from :0 , to:0.8)
                .stroke(AngularGradient(gradient: .init(colors: [APP_THEME_COLOR,.purple ]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: self.animate ? 360 :0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }.onAppear {
            self.animate.toggle()
        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

struct Indicator : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let indi = UIActivityIndicatorView(style: .large)
        indi.color = UIColor.tintColor
        return indi
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
}
