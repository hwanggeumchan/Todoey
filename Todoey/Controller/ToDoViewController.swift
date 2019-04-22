//
//  ToDoViewController.swift
//  Todoey
//
//  Created by Andy Hwang on 4/8/19.
//  Copyright © 2019 GCH. All rights reserved.
//

import Foundation
import UIKit

class ToDoViewController : UITableViewController {
    
    var listArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Walk Mocha"
        listArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Play with Mocha"
        listArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Feed Mocha"
        listArray.append(newItem3)

        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            listArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        let item = listArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
       
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFieldText = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            let newItem = Item()
            newItem.title = textFieldText.text!
            
            self.listArray.append(newItem)
            
            self.defaults.set(self.listArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add an item"
            textFieldText = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
