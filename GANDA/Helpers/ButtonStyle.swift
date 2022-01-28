//
//  ButtonStyle.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/4/22.
//

import SwiftUI
struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(12).padding(.horizontal, 5)
            .background(
                ZStack {
                    //                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                    //                        .shadow(color: .white, radius: configuration.isPressed ? 8: 15, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                    //                        .shadow(color: .clear, radius: configuration.isPressed ? 8: 15, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                    //                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(self.isPressed ? APP_THEME_COLOR : bgColor)
                }
        )
            .scaleEffect(self.isPressed ? 0.95: 1)
            .scaledToFill()
            .foregroundColor(self.isPressed ? Color.white : Color.black)
            .animation(.spring())
            .background(Color("BG"))
            .cornerRadius(15)
//            .shadow(color: Color.black.opacity(self.isPressed ? 0.1: 0.3), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(self.isPressed ? 0.1: 0.3), radius: 1, x: 1, y: 1)

            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
            
            .font(.custom(FONT, size: 18))
    }
}

struct tagButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
          .font(.subheadline)
          .foregroundColor(configuration.isPressed ? .white : .black)
//          .background(configuration.isPressed ? APP_THEME_COLOR: .white)
          .frame(height: 30)
          .padding(.horizontal)
          .overlay (
            Capsule()
                .stroke(Color(.systemGray5), lineWidth: 1))
  }

}

