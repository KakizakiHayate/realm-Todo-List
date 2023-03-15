//
//  TodoModel.swift
//  RealmTutorialProject
//
//  Created by 柿崎逸 on 2023/03/02.
//

import Foundation
import RealmSwift

class TodoItem: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: UUID = UUID()
    @Persisted var text: String = ""
    @Persisted var check: String = ""
    @Persisted var isChecked: Bool = false
    
    static func fetchAllTodo() -> [TodoItem]? {
        guard let localRealm = try? Realm() else { return nil}
        
        let todos = localRealm.objects(TodoItem.self)
        return Array(todos)
    }
    
    static func deleteTodo(todo: TodoItem) {
        guard let localRealm = try? Realm() else { return }
        
        try? localRealm.write {
            localRealm.delete(todo)
        }
    }
}

