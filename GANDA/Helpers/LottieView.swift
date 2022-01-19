//
//  LottieView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/2/22.
//


import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = AnimationView()
        
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.loopMode = LottieLoopMode.loop
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {

    }
    
    
    struct LottieView2: UIViewRepresentable {
        typealias UIViewType = UIView
        var filename: String
        
        func makeUIView(context: UIViewRepresentableContext<LottieView2>) -> UIView {
            let view = UIView(frame: .zero)
            
            let animationView = AnimationView()
            let animation = Animation.named(filename)
            animationView.animation = animation
    //        animationView.loopMode = .repeat(30.0)
            animationView.contentMode = .scaleAspectFill
    //        animationView.play()
            animationView.play { (complete) in
                        animationView.removeFromSuperview()

            }
            animationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(animationView)

            
            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
            
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView2>) {
            
        }
    }


}
