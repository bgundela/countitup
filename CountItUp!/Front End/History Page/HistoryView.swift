//
//  HistoryView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Person.getAllPeople()) var people: FetchedResults<Person>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isPresented = false
    
    @State var activeSheet: ActiveSheet = .create
    
    @State var color = "Default"
    
    @State var indexSet = 0
    
    @State var resetIt = false
    
    @State var summary = ""
    
    @State var show = false
    
    @State var title = ""
    
    @State var msg = ""
    
    @State var presentAlert = false
    
    @State var checkLeft = false
    
    @State var checkRight = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                Color("\(color)")
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                
                HStack {
                    Text("History")
                        .bold()
                        .font(.system(size: 40))
                        .padding()
                }
            }
            
            VStack {
                
                
                Spacer()
                
                if self.people.isEmpty {
                    Text("There is nobody in the group.")
                } else {
                    VStack {
                        
                        Text("\(self.people[indexSet].name): \(self.people[indexSet].points)")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                if indexSet > 0 {
                                    self.indexSet -= 1
                                    checkLeft = false
                                } else {
                                    checkLeft = true
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .frame(width: 37, height: 45)
                                    .foregroundColor(self.checkLeft ? Color("\(color)").opacity(0.5) : Color("\(color)"))
                                    .padding()
                            }
                            
                            Spacer()
                            
                            if self.people[indexSet].image != nil {
                                if self.people[indexSet].image!.count != 0 {
                                    Image(uiImage: UIImage(data: self.people[indexSet].image!)!)
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(75)
                                } else {
                                    Image(systemName: "person.circle.fill")
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(75)
                                        .foregroundColor(.secondary)
                                }
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(75)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                if indexSet < self.people.count - 1 {
                                    self.indexSet += 1
                                    checkRight = false
                                } else {
                                    checkRight = true
                                }
                            }) {
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 37, height: 45)
                                    .foregroundColor(self.checkRight ? Color("\(color)").opacity(0.5) : Color("\(color)"))
                                    .padding()
                            }
                            
                            Spacer()
                        }
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Change")
                                .bold()
                                .foregroundColor(Color("\(self.color)"))
                                .fontWeight(.heavy)
                            
                            Text("\(self.people[indexSet].history)")
                                    .font(.callout)
                        }
                        .padding()
                        .clipShape(Capsule())
                        .border(Color("\(self.color)"))
                    }
                }
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
            
            guard let retrievedSummary = UserDefaults.standard.value(forKey: "summary") else {
                return
            }
            
            self.summary = retrievedSummary as! String
            
            guard let retreivedReset = UserDefaults.standard.value(forKey: "resetIt") else {
                return
            }
            
            self.resetIt = retreivedReset as! Bool
        }
        .alert(isPresented: self.$presentAlert) {
            Alert(title: Text("\(self.title)"), message: Text("\(self.msg)"), dismissButton: .default(Text("OK")))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
