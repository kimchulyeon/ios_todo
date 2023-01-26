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
	//var id: Int
	
	init(keyID: String, dictionary: [String: Any]) {
		self.title = dictionary["title"] as? String ?? ""
		self.isComplete = dictionary["isComplete"] as? Bool ?? false
	}
}

struct PostService {
	static let shared = PostService()
	let DB_REF = Database.database(url: "https://ios-todo-12c99-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
	
	func fetchAllItems(completion: @escaping (([TodoItem]) -> ())) {
		var allItems = [TodoItem]()
		
		DB_REF.child("items").observe(.childAdded) { snapchat in
			fetchSingleItem(id: snapchat.key) { item in
				allItems.append(item)
				completion(allItems)
			}
		}
	}
	func fetchSingleItem(id: String, completion: @escaping (TodoItem) -> ()) {
		DB_REF.child("items").child(id).observeSingleEvent(of: .value) { snapshot in
			guard let dictionary = snapshot.value as? [String: Any] else { return }
			let todoItem = TodoItem(keyID: id, dictionary: dictionary)
			completion(todoItem)
		}
	}
}
