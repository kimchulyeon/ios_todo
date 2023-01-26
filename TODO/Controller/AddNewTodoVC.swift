import UIKit

class AddNewTodoVC: UIViewController {
	//MARK: - Properties
	private let topBar: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .lightGray
		view.layer.cornerRadius = 5
		return view
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 26)
		label.text = "New Todo"
		return label
	}()
	private lazy var addButton: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.backgroundColor = .systemBlue
		btn.layer.cornerRadius = 25
		btn.layer.shadowColor = UIColor.black.cgColor
		btn.layer.shadowOffset = CGSize(width: 0, height: 2)
		btn.layer.shadowRadius = 2
		btn.layer.shadowOpacity = 0.5
		btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		btn.setTitle("Add", for: .normal)
		btn.setTitleColor(.white, for: .normal)
		btn.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
		return btn
	}()

	let addButtonWidth: CGFloat = 20
	var addButtonWidthConstraint = NSLayoutConstraint()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		layout()
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		if #available(iOS 15.0, *) {
			if let sheetController = presentationController as? UISheetPresentationController {
				if let position = sheetController.selectedDetentIdentifier {
					if position == .large {
						addButtonWidthConstraint.constant = 150
					} else {
						addButtonWidthConstraint.constant = 50
					}
				}
			}
		}
	}

	//MARK: - func ============================================
	func layout() {
		view.addSubview(topBar)
		view.addSubview(titleLabel)
		view.addSubview(addButton)

		// top bar
		NSLayoutConstraint.activate([
			topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
			topBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			topBar.heightAnchor.constraint(equalToConstant: 4),
			topBar.widthAnchor.constraint(equalToConstant: 100)
		])
		// title label
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		// add button
		NSLayoutConstraint.activate([
			addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
			addButton.heightAnchor.constraint(equalToConstant: 50),
		])
		addButtonWidthConstraint = addButton.widthAnchor.constraint(equalToConstant: 50)
		addButtonWidthConstraint.isActive = true
	}

	//MARK: - selector ============================================
	@objc func tappedAddButton() {
		print("tap:::::::")
	}
}


