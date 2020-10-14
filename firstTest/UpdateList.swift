//
//  UpdateList.swift
//  firstTest
//
//  Created by MDavid Low on 10/13/20.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate(){
        //default data set
        store.updates.append(Update(image: "Card1", title: "New Item", text: "text", date: "Jan 1"))
    }
    
    var body: some View {
        NavigationView {
            
            //store.update is calling the UpdateStore var
            //list like this is simply for syling
            List{
                //looping thru array
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)) { //destination is set and pass data
                        HStack() {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading) {
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold))
                                
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                        
                    }
                }
                //Swipe to delete
                .onDelete{ index in
                    self.store.updates.remove(at: index.first!)
                }
                //Drag and reorder
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationTitle(Text("Updates"))
            //Below from the tutorial is deprecated
//            .navigationBarTitle(Text("Updates"))
            
        //This replaces .navigationBarItem - which is deprecated
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: addUpdate) { Text("Add Update") }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    //edit button
                    EditButton()
                }
            }
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}


//Data Model
struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}


let updateData = [

    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS", date: "Jan 1"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "Oct 17"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and web", date: "Aug 23"),
    Update(image: "Card4", title: "Swift UI", text: "Learn how to code custim UIs, animations, gestures and components in XCode 11", date: "Jun 26"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with Framer X code editor", date: "Jun 11")
    
]
