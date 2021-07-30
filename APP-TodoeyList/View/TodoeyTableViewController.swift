//
//  TodoeyTableViewController.swift
//  APP-TodoeyList
//
//  Created by José Eduardo Rodríguez Reyes on 25/07/21.
//

import UIKit
//* Estudiar secuencia de eventos
class TodoeyTableViewController: UITableViewController {

    var toDoItem = [ItemModel]()
    /// User Defaults Constant
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todoey List"
        
        let item = ItemModel()
        item.toDoTitle = "Buy eggs"
        item.done = true
        toDoItem.append(item)
        let item2 = ItemModel()
        item2.toDoTitle = "Study Swift"
        item2.done = false
        toDoItem.append(item2)
        let item3 = ItemModel()
        item3.toDoTitle = "Study Python"
        item3.done = true
        toDoItem.append(item3)
        
        // Recuperar datos del user defaults
//        if let myItems = defaults.array(forKey: "ToDoListArray") as? [String] {
//            toDoItem = myItems
//            defaults.synchronize()
//        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //Add a section for each day
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ReusableCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = toDoItem[indexPath.row].toDoTitle
        // Add a checkmark to each cell; ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        let item = toDoItem[indexPath.row]
        cell.accessoryType = item.done ? .checkmark : .none
        
        /*if toDoItem[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else { cell.accessoryType = .none }*/
        
        return cell
    }

    //MARK: - Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Change the Done property if we selected a cell
        toDoItem[indexPath.row].done = !toDoItem[indexPath.row].done
        /*if toDoItem[indexPath.row].done == false {
            toDoItem[indexPath.row].done = true
        } else { toDoItem[indexPath.row].done = false }*/
        
        tableView.reloadData()
        // unselected the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.presentAnAlert(titleAlert: "Add new todey item", titleAlertAction: "Add a item")
        //defaults.removeObject(forKey: "ToDoListArray")
        //defaults.synchronize()
    }
    
    //MARK: - My Functions
    func presentAnAlert(titleAlert title: String, titleAlertAction titleAction: String) {
        // variable al alcance de toda la funcion
        var textField = UITextField()
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: titleAction, style: .default) { (action) in
            // what will happen once the user clicks the Add item action on our UIAlert
            let newItem = ItemModel()
            newItem.toDoTitle = textField.text!
            // we become the array to a objects array
            if textField.text != nil {
                self.toDoItem.append(newItem)
                // Save in user defaults
                self.defaults.set(self.toDoItem, forKey: "ToDoListArray")
                self.tableView.reloadData()
            } else {
                print("Nothing were added")
            }
            
        }
        // this closure only actives when the textfield added to the alert
        alert.addTextField { (myTextFieldAlert) in  // local variable ONLY inside this closure
            myTextFieldAlert.placeholder = "Create new Item"
            textField = myTextFieldAlert
            /*de esta forma el texto añadido se lo pasamos
             a textField ya que es una variable local
             al alcance de toda la funcion */
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
