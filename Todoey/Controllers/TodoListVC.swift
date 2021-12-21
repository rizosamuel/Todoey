//
//  ViewController.swift
//  Todoey
//
//  Created by Rijo Samuel on 21/12/21.
//

import UIKit

final class TodoListVC: UITableViewController {
	
	private let userDefaults = UserDefaults.standard
	private var itemArray: [Item] = []
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		populateWithDummyData()
	}
	
	private func populateWithDummyData() {
		
		let item = Item()
		item.title = "Find Mike"
		
		let item2 = Item()
		item2.title = "Buy Eggos"
		
		let item3 = Item()
		item3.title = "Destroy Demogorgon"
		
		itemArray.append(item)
		itemArray.append(item2)
		itemArray.append(item3)
		
		if let array = userDefaults.array(forKey: "TodoListArray") as? [Item] {
			itemArray = array
		}
	}
	
	@IBAction private func didTapAddButton(_ sender: UIBarButtonItem) {
		
		var alertTextField = UITextField()
		let title = "Add New Todoey Item"
		let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
		let actionTitle = "Add Item"
		let action = UIAlertAction(title: actionTitle, style: .default) { action in
			
			let item = Item()
			item.title = alertTextField.text ?? ""
			self.itemArray.append(item)
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
		let item = itemArray[indexPath.row]
		cell.accessoryType = item.done ? .checkmark : .none
		cell.textLabel?.text = item.title
		return cell
	}
}

// MARK: - Table View Delegate Methods
extension TodoListVC {
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		tableView.deselectRow(at: indexPath, animated: true)
		tableView.reloadData()
	}
}
