//
//  PostService.swift
//  TODO
//
//  Created by chulyeon kim on 2023/01/26.
//

import UIKit
import Firebase

struct TodoItem {
	var title: String
	var isComplete: Bool
	var id: String
	
	init(keyID: String, dictionary: [String: Any]) {
		self.title = dictionary["title"] as? String ?? ""
		self.isComplete = dictionary["isComplete"] as? Bool ?? false
		self.id = dictionary["id"] as? String ?? ""
	}
}

struct PostService {
	static let shared = PostService()
	let DB_REF = Database.database(url: "https://ios-todo-12c99-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
	
	func fetchAllItems(completion: @escaping (([TodoItem]) -> ())) {
		var allItems = [TodoItem]()
		
		// 데이터베이스에 items안의 데이터가 추가되는걸 감지해서 키값을 completion으로 넘겨 fetchSingleItem에 파라미터로 넘긴다.
		DB_REF.child("items").queryOrdered(byChild: "isComplete").observe(.childAdded) { snapshot in
			
			// 하나의 todo 객체를 item으로 받아서 배열에 저장
			fetchSingleItem(id: snapshot.key) { item in
				allItems.append(item)
				completion(allItems)
			}
		}
	}
	// 하나의 todo 객체를 completion으로 넘긴다.
	func fetchSingleItem(id: String, completion: @escaping (TodoItem) -> ()) {
		DB_REF.child("items").child(id).observeSingleEvent(of: .value) { snapshot in
			guard let dictionary = snapshot.value as? [String: Any] else { return }
			let todoItem = TodoItem(keyID: id, dictionary: dictionary)
			completion(todoItem)
		}
	}
	
	// todo 업로드
	func uploadTodoItem(text: String, completion: @escaping (Error?, DatabaseReference) -> ()) {
		let id = DB_REF.child("items").childByAutoId()
		let values = ["id": "\(id.key!)", "title": text, "isComplete": false] as [String: Any]
		
		id.updateChildValues(values, withCompletionBlock: completion)
	}
	
	// todo 상태 변경
	func updateTodoStatus(todoId: String, isComplete: Bool, completion: @escaping (Error?, DatabaseReference) -> ()) {
		let value = ["isComplete": isComplete]
		DB_REF.child("items").child(todoId).updateChildValues(value, withCompletionBlock: completion)
	}
	
	func deleteTodo(todoId: String, completion: @escaping (Error?, DatabaseReference) -> ()) {
		DB_REF.child("items").child(todoId).removeValue(completionBlock: completion)
	}
}
