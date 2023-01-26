import UIKit

class TodoListTVC: UITableViewController {
	//MARK: - Properties
	let REUSEID = "todoCell"
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureTV()
	}
	
	//MARK: - func ============================================
	func configureTV() {
		tableView.register(TodoCell.self, forCellReuseIdentifier: REUSEID)
		tableView.rowHeight = 75
		tableView.separatorColor = .darkGray
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		tableView.tableFooterView = UIView()
	}
}


extension TodoListTVC {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: REUSEID, for: indexPath) as? TodoCell else { return UITableViewCell() }
		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		// 할일 진행중 -> 완료로 변경
	}
}
