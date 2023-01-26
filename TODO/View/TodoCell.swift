import UIKit

class TodoCell: UITableViewCell {
	//MARK: - properties ============================================
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.text = "title label"
		return label
	}()
	private let statusLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 18)
		label.text = "status label"
		return label
	}()
	
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
	}
	func configure() {
		
	}
}
