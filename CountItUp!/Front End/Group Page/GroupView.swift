//
//  GroupView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

enum ActiveSheet {
    case create
    case modify
}

struct GroupView: View {
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
                    Text("My Group")
                        .bold()
                        .font(.system(size: 40))
                        .padding()
                }
            }
            
            Spacer()
            
            Button(action: {
                self.activeSheet = .create
                
                self.isPresented.toggle()
            }) {
                Text("Add A Member")
                .font(.title)
                .padding()
                .foregroundColor(Color("\(color)"))
                .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                .background(Color("\(color)").opacity(0.4))
                .cornerRadius(25)
            }
            
            HStack {
                Text("My Current Group")
                
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
                    Text("\(self.people[indexSet].name): \(self.people[indexSet].points)")
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    HStack {
                        
                        Spacer()
                        
                        Image(uiImage: UIImage(data: self.people[indexSet].image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(75)
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.activeSheet = .modify
                            
                            self.isPresented.toggle()
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .padding()
                                .foregroundColor(Color("\(color)"))
                                .frame(width: 150, height: 50)
                                .background(Color("\(color)").opacity(0.4))
                                .cornerRadius(25)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            DispatchQueue.main.async {
                                self.deleteValue(at: IndexSet(integer: indexSet))
                            }
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.title)
                                .padding()
                                .foregroundColor(Color("\(color)"))
                                .frame(width: 150, height: 50)
                                .background(Color("\(color)").opacity(0.4))
                                .cornerRadius(25)
                        }
                        
                        Spacer()
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .sheet(isPresented: self.$isPresented) {
            if activeSheet == .create {
                AddSheetView()
            } else {
                ModifySheetView(person: self.people[indexSet], indexSet: self.$indexSet)
            }
        }
        .onAppear {
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
        }
    }
    
    func deleteValue(at offsets: IndexSet) {
        for index in offsets {
            let deleteItem = people[index]
            self.moc.delete(deleteItem)
            
            
            
            try! self.moc.save()
        }
    }
    
    func updateValue(at indexSet: Int, update key: String, to value: Any) {
        let updateItem = self.people[indexSet]
        updateItem.setValue(value, forKey: key)
        
        try! self.moc.save()
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
