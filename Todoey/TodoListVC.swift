//
//  ViewController.swift
//  Todoey
//
//  Created by Rijo Samuel on 21/12/21.
//

import UIKit

final class TodoListVC: UITableViewController {
	
	private let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgan"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
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
