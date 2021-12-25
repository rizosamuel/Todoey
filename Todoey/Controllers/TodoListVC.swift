//
//  ViewController.swift
//  Todoey
//
//  Created by Rijo Samuel on 21/12/21.
//

import UIKit
import CoreData

final class TodoListVC: UITableViewController {
	
	private let coreDataContext: NSManagedObjectContext
	private let userDefaults = UserDefaults.standard
	private var itemArray: [Item] = []
	
	init() {
		
		self.coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		super.init()
	}
	
	required init?(coder: NSCoder) {
		
		self.coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		super.init(coder: coder)
		// fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		loadItems()
		// populateWithDummyData()
	}
	
	@IBAction private func didTapAddButton(_ sender: UIBarButtonItem) {
		
		var alertTextField = UITextField()
		let title = "Add New Todoey Item"
		let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
		let actionTitle = "Add Item"
		let action = UIAlertAction(title: actionTitle, style: .default) { action in
			
			let item = Item(context: self.coreDataContext)
			item.title = alertTextField.text ?? ""
			item.done = false
			self.itemArray.append(item)
			self.tableView.reloadData()
			self.saveItems()
			// self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
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
		saveItems()
	}
}

// MARK: - Model Manipulation Methods
extension TodoListVC {
	
	private func saveItems() {
		
		do {
			try self.coreDataContext.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
		
		do {
			itemArray = try coreDataContext.fetch(request)
		} catch {
			print(error.localizedDescription)
		}
	}
}

// MARK: - Search Bar Delegate Methods
extension TodoListVC: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		let request: NSFetchRequest<Item> = Item.fetchRequest()
		let predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		
		request.predicate = predicate
		request.sortDescriptors = [sortDescriptor]
		
		loadItems(with: request)
		tableView.reloadData()
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		guard searchBar.text?.count != 0 else {
			loadItems()
			tableView.reloadData()
			DispatchQueue.main.async { searchBar.resignFirstResponder() }
			return
		}
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		view.endEditing(true)
	}
}
