//
//  SettingView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 12/30/21.
//

import SwiftUI

struct SettingsView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.presentationMode) var presentationMode
  @AppStorage("isOnboarding") var isOnboarding: Bool = false
  
  // MARK: - BODY

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 20) {
          // MARK: - SECTION 1
          
          GroupBox(
            label:
              SettingsLabelView(labelText: APP_NAME, labelImage: "info.circle")
          ) {
            Divider().padding(.vertical, 4)
            
            HStack(alignment: .center, spacing: 10) {
              Image("logo-setting")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .cornerRadius(9)
              Spacer()
              Text(APP_DESC)
                    .font(Font.custom(FONT, size: 12))
            }
          }
       
          
          // MARK: - SECTION 2
          
//          GroupBox(
//            label: SettingsLabelView(labelText: "Customization", labelImage: "paintbrush")
//          ) {
//            Divider().padding(.vertical, 4)
//
//            Text("If you wish, you can restart the application by toggle the switch in this box. That way it starts the onboarding process and you will see the welcome screen again.")
//              .padding(.vertical, 8)
//              .frame(minHeight: 60)
//              .layoutPriority(1)
//              .font(.footnote)
//              .multilineTextAlignment(.leading)
//
//            Toggle(isOn: $isOnboarding) {
//              if isOnboarding {
//                Text("Restarted".uppercased())
//                  .fontWeight(.bold)
//                  .foregroundColor(Color.green)
//              } else {
//                Text("Restart".uppercased())
//                  .fontWeight(.bold)
//                  .foregroundColor(Color.secondary)
//              }
//            }
//            .padding()
//            .background(
//              Color(UIColor.tertiarySystemBackground)
//                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//            )
//          }
          
          // MARK: - SECTION 3
          
          GroupBox(
            label:
            SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
          ) {
            SettingsRowView(name: DEVELOPER , content: "GANDA LAB")
            SettingsRowView(name: MIN_REQUIREMENT, content: "iOS 15")
            SettingsRowView(name: HOMEPAGE, linkLabel: "Company Website", linkDestination: "")
            SettingsRowView(name: TWITTER_PAGE, linkLabel: "@srdpt3", linkDestination: "")
            SettingsRowView(name: VERSION, content: APP_VERSION)
          }
          
        } //: VSTACK
        .navigationTitle("").navigationBarHidden(true)
//        .navigationBarTitle(Text("애플리케이션 정보").foregroundColor(Color.gray), displayMode: .large)
//        .navigationBarItems(
//          trailing:
//            Button(action: {
//              presentationMode.wrappedValue.dismiss()
//            }) {
//              Image(systemName: "xmark")
//            }
//        )
        .padding().padding(.top, 30)
//        .navigationBarHidden(true)

      } //: SCROLL
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
      .preferredColorScheme(.dark)
      .previewDevice("iPhone 11 Pro")
  }
}

struct TransparentGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color("Blue")))
            .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
    }
}
