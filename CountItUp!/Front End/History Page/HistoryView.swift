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
                Button(action: {
                    if self.people.isEmpty {
                        print("Empty")
                    } else {
                        for person in self.people {
                            person.history = "No History."
                        }
                    }
                    
                }) {
                    Text("Delete All History")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color("\(color)"))
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .background(Color("\(color)").opacity(0.4))
                    .cornerRadius(25)
                }
                
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
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .frame(width: 37, height: 45)
                                    .foregroundColor(Color("\(color)"))
                                    .padding()
                            }
                            
                            Spacer()
                            
                            Image(uiImage: UIImage(data: self.people[indexSet].image)!)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(75)
                            
                            Spacer()
                            
                            Button(action: {
                                if indexSet < self.people.count - 1 {
                                    self.indexSet += 1
                                }
                            }) {
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 37, height: 45)
                                    .foregroundColor(Color("\(color)"))
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
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
