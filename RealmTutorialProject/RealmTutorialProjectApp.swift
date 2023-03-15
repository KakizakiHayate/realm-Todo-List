//
//  RealmTutorialProjectApp.swift
//  RealmTutorialProject
//
//  Created by 柿崎逸 on 2023/03/01.
//

import SwiftUI
import RealmSwift

@main
struct RealmTutorialProjectApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView(todoItems: TodoItem())
        }
    }
}
