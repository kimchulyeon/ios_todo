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
	private let textField: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.font = .systemFont(ofSize: 24)
		tf.textColor = .darkGray
		tf.backgroundColor = UIColor(hue: 0.56, saturation: 0.3, brightness: 0.9, alpha: 0.7)
		tf.autocapitalizationType = .none
		return tf
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
		btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
		btn.setTitle("Add", for: .normal)
		btn.setTitleColor(.white, for: .normal)
		btn.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
		return btn
	}()

	let addButtonWidth: CGFloat = 20
	var addButtonWidthConstraint = NSLayoutConstraint()

	var buttonBottomConstraint = NSLayoutConstraint()
	var keyboardHeight: CGFloat = 0

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		layout()
		delegates()
		tapGestureConfigure()
	}

//	override func viewWillLayoutSubviews() {
//		super.viewWillLayoutSubviews()
//
//		if #available(iOS 15.0, *) {
//			if let sheetController = presentationController as? UISheetPresentationController {
//				if let position = sheetController.selectedDetentIdentifier {
//					if position == .large {
//						addButtonWidthConstraint.constant = 150
//					} else {
//						addButtonWidthConstraint.constant = 50
//					}
//				}
//			}
//		}
//	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	//MARK: - func ============================================
	func layout() {
		view.backgroundColor = .white

		view.addSubview(topBar)
		view.addSubview(titleLabel)
		view.addSubview(textField)
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
		// text field
		NSLayoutConstraint.activate([
			textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 128),
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			textField.heightAnchor.constraint(equalToConstant: 40)
		])
		// add button
		NSLayoutConstraint.activate([
//			addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			addButton.heightAnchor.constraint(equalToConstant: 50),
			addButton.widthAnchor.constraint(equalToConstant: 200),
			addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		buttonBottomConstraint = addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
		buttonBottomConstraint.isActive = true
	}
	func delegates() {
		textField.delegate = self
	}
	func tapGestureConfigure() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhenTapOutside))
		view.addGestureRecognizer(tap)
	}

	//MARK: - selector ============================================
	@objc func tappedAddButton(_ sender: UIButton) {
		UIView.animate(withDuration: 0.1, animations: {
			sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
		}) { [weak self] _ in
			sender.transform = .identity
			
			guard let todo = self?.textField.text else { return }
			PostService.shared.uploadTodoItem(text: todo) { [weak self] (err, ref) in
				self?.textField.text = ""
				self?.dismiss(animated: true)
			}
		}
	}
	@objc func dismissKeyboardWhenTapOutside() {
		view.endEditing(true)
	}
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			keyboardHeight = keyboardSize.height
			buttonBottomConstraint.constant = -keyboardHeight - 15
			UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { [weak self] in
				self?.view.layoutIfNeeded()
			})
		}
	}
	@objc func keyboardWillHide(notification: NSNotification) {
		buttonBottomConstraint.constant = -15
		UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { [weak self] in
			self?.view.layoutIfNeeded()
		})
	}
}

//MARK: - UITextFieldDelegate ============================================
extension AddNewTodoVC: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
	}
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		return true
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
