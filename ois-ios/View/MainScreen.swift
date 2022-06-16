//
//  MainScreen.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 04.05.2022.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    let text : String
    let handler: (_ item: MenuItem) ->Void = {item in
        

        print(item)
        if item.text == "Поликлиники"{
            
        }
    }
    var imageName: String
}

struct MenuContent: View {
    @State private var selection: Bool = false

    let items : [MenuItem] = [
        MenuItem(text: "Поликлиники", imageName: "house"),
        MenuItem(text: "Роли",imageName: "house"),
        MenuItem(text: "Права доступа", imageName: "house"),
        MenuItem(text: "Должности", imageName: "house"),
        MenuItem(text: "Замещение", imageName: "house"),
        MenuItem(text: "Увольнение сотрудника", imageName: "house")
    ]
    var body: some View {
        
        ZStack {
            Color(UIColor(.white))
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    HStack {
                        Image("Profile photo")
                        VStack (alignment: .leading,spacing: 5) {
                            Text("Admin Admin")
//                                .foregroundColor(.white)
                            Text("Администратор")
//                                .foregroundColor(.white)
                        }
                    }
                }
                ForEach(items) { item in
                    HStack {
                        Image(systemName: item.imageName)
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35, alignment: .center)
                        Text(item.text)
                            .bold()
                            .multilineTextAlignment(.leading)
//                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        item.handler(item)
                        selection = (item.text == "Роли")
                        print(selection)
                        NavigationLink(destination: Text("Second View"), isActive: $selection) { EmptyView() }
                    }
                    
                }
                Spacer()
            }.padding(.top, 15)
        }
    }
}

struct SlideMenu: View {
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
                
            }.background(Color.gray.opacity(self.menuOpened ? 1: 0))
                .opacity(self.menuOpened ? 1 : 0)
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                    self.toggleMenu()
                }
            
//            Content
            HStack {
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.default)
                Spacer()
            }
        }
    }
}


struct MainScreen: View {
    @State var username: String = ""
    @State var menuOpen = false

    var items: [Item]
    var body: some View {
        
        ZStack{
            NavigationView {
                
                
            VStack {
                
                HStack {
                    Button (action: {
                        self.toggleMenu()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                    })
                    TextField("Сотрудник, подразделение", text: $username, onEditingChanged: { (changed) in
                                    print("Search changed - \(changed)")
                                }) {
                                    
                                }
                    Button {
                        print("Edit button was tapped")
//                        self.menuOpen.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                    List(items, children: \.children) {
                        Text($0.title)
                    }
                
            }.navigationBarTitle("Поликлиника", displayMode: .inline)
                    .offset(y: 5)
                
            
            }.edgesIgnoringSafeArea(.all)
            SlideMenu(width: UIScreen.main.bounds.width / 2, menuOpened: menuOpen, toggleMenu: toggleMenu)
        
        }
    }
    func toggleMenu() {
        menuOpen.toggle()
    }
    func loadData() {
        
    }
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(items: Item.stubs)
    }
}

extension Item {
    static var stubs: [Item] = [
        Item(title: "Онкологический центр", children: [
            Item(title: "12 Поликлиника", children:
                    [
                        Item(title: "Хирурги", children: nil),
                        Item(title: "Медсестры и медбраты", children: nil),
                    ]
                ),
            Item(title: "Тест", children: nil),
            Item(title: "Тест", children: nil),
        ]),
        Item(title: "Отдел онкологий", children: [
            Item(title: "Хирурги", children: nil),
            Item(title: "Медсестры и медбраты", children: nil),
        ]),
    ]
}

