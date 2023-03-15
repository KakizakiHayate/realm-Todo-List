//
//  ContentView.swift
//  RealmTutorialProject
//
//  Created by 柿崎逸 on 2023/03/01.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var textfield = ""
    @State var nextMigraion: UInt64 = 8
    @State var checkArray: [TodoItem] = []
    
    @ObservedResults(TodoItem.self) var todoItems
    
    init(textfield: String = "", todoItems: TodoItem) {
        self.textfield = textfield
        let config = Realm.Configuration(schemaVersion: nextMigraion)
        Realm.Configuration.defaultConfiguration = config
    }
    
    func version() {
        
    }
    var body: some View {
        VStack {
            TextField("追加", text: $textfield)
            
            HStack {
                Button(action: {
                    let todo = TodoItem()
                    todo.text = textfield
                    let config = Realm.Configuration(schemaVersion: nextMigraion)
                    Realm.Configuration.defaultConfiguration = config
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(todo)
                    }
                    
                    if !textfield.isEmpty {
                        textfield = ""
                    }
                }) {
                    Text("テキストを追加")
            }
                
                Button(action: {
                    let config = Realm.Configuration(schemaVersion: nextMigraion)
                    Realm.Configuration.defaultConfiguration = config
                    let realm = try! Realm()

                    let obj = realm.objects(TodoItem.self)

                    try! realm.write {
                        realm.delete(obj)
                    }


                }) {
                    Text("全削除")
                }
                
               
            }
            
            List {
             ForEach(todoItems) { item in
                    VStack {
                        HStack {
//                            if item.isChecked {
//                                Image(systemName: "checkmark.circle")
//                            } else {
//                                Image(systemName: "circle")
//                            }
                            
                            Button(action: {
                                checkArray.append(item)
                                print("\(checkArray.count)")
                                
                                
                            }) {
                                Text((item.text))
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }                    }
                }
            }
        }
        .padding()
        .onAppear {
            let localRealm = try! Realm()
            let obj = localRealm.objects(TodoItem.self)
            
            if obj.isEmpty {
                print("中身は空でした！！")
            } else {
                print("中身は入っています。")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(todoItems: TodoItem())
    }
}
