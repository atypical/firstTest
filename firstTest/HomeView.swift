//
//  HomeView.swift
//  firstTest
//
//  Created by MDavid Low on 10/8/20.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                //passed binding state requires $ to call it
                AvatarView(showProfile: $showProfile)
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            //SCROLL VIEW!!!!!!!
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    //Data Loop, for each item in sectionData array, create a SectionView
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in //allows for reading geomtry of this wrap
                            SectionView(section: item)
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in: .global).minX - 30) / -20 //.minX posistion changes as we scroll, also dividing it by 20, the -30 takes away the offset
                                ), axis: (x: 0, y: 10, z: 0))
                        }
                        .frame(width: 275, height: 275)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //required and set to constant false
        HomeView(showProfile: .constant(false))
    }
}


struct SectionView: View {
    //Set data model var
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)

                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}


//"Data Model"
struct Section: Identifiable{
    //Unique ID
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

//Data array
let sectionData = [
    Section(title: "Prototype designs in SwfitUI", text: "18 Section", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card5")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    Section(title: "Build a SwfitUI app", text: "20 Section", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))),
    Section(title: "SwfitUI Advanced", text: "23 Section", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card6")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
]

