//
//  Home.swift
//  firstTest
//
//  Created by MDavid Low on 10/7/20.
//

import SwiftUI
//Color extensions for reusability - move to design system
extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}


struct Home: View {
    
    @State var showProfile = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {            
            HomeView(showProfile: $showProfile)
                //This padding is bc the ignore safe space overrides the native safe space
                .padding(.top, 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 :0), axis: (x: 10.0, y: 0, z: 0))
                //scale down the main view bg
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            
            //THIS IS ALL U NEED TO PULL IN A VIEW??!?!?!
            //showProfile ? questions invoke the menu view
            MenuView()
                .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                //set the y to the viewState modified by .gesture below
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                //tapping the menu view toggles the bool
                .onTapGesture{
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                    }
                    .onEnded{ value in
                        //if its dragged below 50, hide profile
                        if self.viewState.height > 50{
                            self.showProfile = false
                        }
                        self.viewState = .zero
                    }
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: { self.showProfile.toggle() } ) {
            Image("Avatar")
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

//because its outside of everything, it's availabel to all files
let screen = UIScreen.main.bounds
