
import SwiftUI

struct MainView: View {
    // selected Tab...
    @State var selectedTab = "Card"
    @State var showMenu = false
    @State var showDetailView = false

    let haptics = UINotificationFeedbackGenerator()
    @EnvironmentObject var observer: Observer

    var body: some View {
       
        ZStack{
            
            APP_THEME_GRADIENT.ignoresSafeArea()
//            APP_THEME_COLOR.ignoresSafeArea()
            
            // Side Menu...
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false, content: {
                
                SideMenu(selectedTab: $selectedTab, showMenu: $showMenu)
            })

            ZStack{
                
                // two background Cards...
                
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    // Shadow...
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical,30)
                
                Color.white
                    .opacity(0.4)
                    .cornerRadius(showMenu ? 15 : 0)
                    // Shadow...
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical,60)
                
                Home(selectedTab: $selectedTab, showMenu: $showMenu,showDetailView:$showDetailView)
                    .cornerRadius(showMenu ? 15 : 0)
                    .disabled(showMenu ? true : false)
            }
            // Scaling And Moving The View...
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea().zIndex(1)
            .overlay(
            
                // Menu Button...
                Button(action: {
                    withAnimation(.spring()){
                        self.haptics.notificationOccurred(.success)

                        showMenu.toggle()
                    }
                }, label: {
                    
                    // Animted Drawer Button..
                    VStack(spacing: 5){
                        
                        Capsule()
                            .fill(showMenu ? Color.white : APP_THEME_COLOR)
                            .frame(width: 30, height: 4)
                        // Rotating...
                            .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                            .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)

                        VStack(spacing: 5){
                            
                            Capsule()
                                .fill(showMenu ? Color.white :APP_THEME_COLOR)
                                .frame(width: 30, height: 4)
                            // Moving Up when clicked...
                            Capsule()
                                .fill(showMenu ? Color.white : APP_THEME_COLOR)
                                .frame(width: 30, height:4)
                                .offset(y: showMenu ? -8 : 0)
                        }
                        .rotationEffect(.init(degrees: showMenu ? 50 : 0))
                    }
                    .contentShape(Rectangle())
                })
                .opacity(showDetailView ? 0 :1)
                .padding().offset(y: -5)
                ,alignment: .topLeading
                    
                
                
                
                
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
