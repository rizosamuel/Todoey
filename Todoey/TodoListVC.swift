//
//  ViewController.swift
//  Todoey
//
//  Created by Rijo Samuel on 21/12/21.
//

import UIKit

final class TodoListVC: UITableViewController {
	
	private let userDefaults = UserDefaults.standard
	private var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgan"]
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		if let array = userDefaults.array(forKey: "TodoListArray") as? [String] {
			itemArray = array
		}
	}
	
	@IBAction private func didTapAddButton(_ sender: UIBarButtonItem) {
		
		var alertTextField = UITextField()
		let title = "Add New Todoey Item"
		let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
		let actionTitle = "Add Item"
		let action = UIAlertAction(title: actionTitle, style: .default) { action in
			self.itemArray.append(alertTextField.text ?? "")
			self.tableView.reloadData()
			self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
		}
		
		alert.addAction(action)
		
		alert.addTextField { textField in
			textField.placeholder = "create new item..."
			alertTextField = textField
		}
		
		present(alert, animated: true)
	}
}

// MARK: - Table View Datasource Methods
extension TodoListVC {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
		cell.textLabel?.text = itemArray[indexPath.row]
		return cell
	}
}

// MARK: - Table View Delegate Methods
extension TodoListVC {
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// print(itemArray[indexPath.row])
		let accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType ?? .none
		tableView.cellForRow(at: indexPath)?.accessoryType = accessoryType == .checkmark ? .none : .checkmark
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
