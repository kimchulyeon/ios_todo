import UIKit

protocol DeleteTableViewCellDelegate: AnyObject {
	func deleteTodo(_ sender: UITableViewCell)
}

class TodoCell: UITableViewCell {
	//MARK: - properties ============================================
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.text = "title label"
		return label
	}()
	let statusLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 18)
		label.text = "status label"
		return label
	}()
	lazy var deleteButton: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setImage(UIImage(systemName: "trash"), for: .normal)
		btn.backgroundColor = .lightGray
		btn.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
		return btn
	}()
	
	var delegate: DeleteTableViewCellDelegate?
	
	//MARK: - lifecycle ============================================
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - func ============================================
	func layout() {
		addSubview(titleLabel)
		addSubview(statusLabel)
		contentView.addSubview(deleteButton)
		
		// title label
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
		])
		// status label
		NSLayoutConstraint.activate([
			statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
		])
		// delete button
		NSLayoutConstraint.activate([
			deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			deleteButton.widthAnchor.constraint(equalToConstant: 35),
			deleteButton.heightAnchor.constraint(equalToConstant: 35)
		])
	}
	
	//MARK: - selector ============================================
	@objc func tapDeleteButton() {
		delegate?.deleteTodo(self)
	}
}
