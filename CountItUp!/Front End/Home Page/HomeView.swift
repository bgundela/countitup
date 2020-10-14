//
//  HomeView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Person.getAllPeople()) var people: FetchedResults<Person>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var activeSheet: ActiveSheet = .create
    
    @State var color = "Default"
    
    @State var indexSet = 0
    
    @State var increment = 1
    
    @State var increments = [1, 2, 3, 4, 5, 10, 20, 50, 100, 500, 1000]
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                Color("\(color)")
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                
                HStack {
                    Text("Count It Up!")
                        .bold()
                        .font(.system(size: 40))
                        .padding()
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(self.getDate())")
                    .bold()
                    .font(.title)
            }
            
            HStack {
                Text("Points Manager")
                
                Spacer()
                
            }
            .padding()
            
            HStack {
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
            }
            
            
            if self.people.isEmpty {
                Text("There is nobody in the group.")
            } else {
                VStack {
                    Text("\(self.people[indexSet].name)")
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            self.people[indexSet].points -= increment
                            
                            self.people[indexSet].history = "\(self.people[indexSet].name)'s points were changed to \(self.people[indexSet].points)"
                            
                            try! self.moc.save()
                        }) {
                            Text("-")
                                .font(.system(size: 75))
                                .frame(width: 45, height: 37)
                                .foregroundColor(Color("\(color)"))
                                .padding()
                        }
                        
                        Spacer()
                        
                        Image("profile")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(75)
                        
                        Spacer()
                        
                        Button(action: {
                            self.people[indexSet].points += increment
                            
                            self.people[indexSet].history = "\(self.people[indexSet].name)'s points were changed to \(self.people[indexSet].points)"
                            
                            try! self.moc.save()
                            
                        }) {
                            Text("+")
                                .font(.system(size: 75))
                                .frame(width: 45, height: 37)
                                .foregroundColor(Color("\(color)"))
                                .padding()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("\(self.people[indexSet].points)")
                            .fontWeight(.heavy)
                            .font(.system(size: 35))
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            guard let retrievedIncrement = UserDefaults.standard.value(forKey: "increment") else {
                return
            }
            
            let recievedIncrement = retrievedIncrement as! Int
            
            self.increment = self.increments[recievedIncrement]
            
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
        }
    }
    
    func updateValue(at indexSet: Int, update key: String, to value: Any) {
        let updateItem = self.people[indexSet]
        updateItem.setValue(value, forKey: key)
        
        try! self.moc.save()
    }
    
    func getDate() -> String {
        let datenow = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: datenow)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
