import UIKit

class TodoListTVC: UITableViewController {
	//MARK: - Properties
	let REUSEID = "todoCell"

	lazy var newTodoButton: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.tintColor = .white
		btn.backgroundColor = .systemBlue
		btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
		btn.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
		btn.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
		btn.layer.cornerRadius = 20
		btn.layer.shadowColor = UIColor.black.cgColor
		btn.layer.shadowOffset = CGSize(width: 0, height: 2)
		btn.layer.shadowRadius = 2
		btn.layer.shadowOpacity = 0.5
		btn.alpha = 1
		return btn
	}()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		configureTV()
		layout()
	}

	//MARK: - func ============================================
	func configureTV() {
		tableView.register(TodoCell.self, forCellReuseIdentifier: REUSEID)
		tableView.rowHeight = 75
		tableView.separatorColor = .systemBlue
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		tableView.tableFooterView = UIView()
	}
	func layout() {
		view.addSubview(newTodoButton)

		// new todo button
		NSLayoutConstraint.activate([
			newTodoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
			newTodoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			newTodoButton.widthAnchor.constraint(equalToConstant: 40),
			newTodoButton.heightAnchor.constraint(equalToConstant: 40),
		])
	}

	//MARK: - selector ============================================
	@objc func addTodo() {
		let vc = AddNewTodoVC()
		if #available(iOS 15.0, *) {
			if let presentationController = vc.presentationController as? UISheetPresentationController {
				presentationController.detents = [.medium(), .large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
			}
		} else {
			// Fallback on earlier versions
		}
		present(vc, animated: true)
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
