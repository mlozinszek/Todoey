//
//  ViewController.swift
//  Todoey
//
//  Created by Michał Lozinszek on 24/04/2020.
//  Copyright © 2020 Michał Lozinszek. All rights reserved.
//

import UIKit

class ToDOListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newItem1 = Item ()
        newItem1.title = "Kup mleko"
        newItem1.done = false
        itemArray.append(newItem1)
        
        var newItem2 = Item ()
        newItem2.title = "Kup sos"
        newItem2.done = false
        itemArray.append(newItem2)
        
        var newItem3 = Item ()
        newItem3.title = "Kup ciastka"
        newItem3.done = false
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
        
    }

    //MARK - Tableview Detasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Item

    @IBAction func addButtonPresse(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey TIem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
            alert.addTextField { (alertTextFild) in
            alertTextFild.placeholder = "Create new item"
            textField = alertTextFild
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
    }



}
