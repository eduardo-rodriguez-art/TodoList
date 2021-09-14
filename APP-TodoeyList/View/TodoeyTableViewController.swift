//
//  TodoeyTableViewController.swift
//  APP-TodoeyList
//
//  Created by José Eduardo Rodríguez Reyes on 25/07/21.
//

import UIKit
import CoreData
//* Estudiar secuencia de eventos
class TodoeyTableViewController: UITableViewController {
    
    var toDoItem = [Item]()
    /// User Defaults Constant
    let defaults = UserDefaults.standard
    let NSDataFieldPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // Create a new object from AppDelegate
    let MyNSContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todoey List"
        
        
        // Recuperar datos del user defaults
        /*if let myItems = defaults.array(forKey: "ToDoListArray") as? [ItemModel] {
            toDoItem = myItems
            defaults.synchronize()  }*/
        self.loadItems()
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
        // Remove the cells
        //MyNSContext.delete(toDoItem[indexPath.row])
        //toDoItem.remove(at: indexPath.row)
        // Change the Done property if we selected a cell
        toDoItem[indexPath.row].done = !toDoItem[indexPath.row].done
        /*if toDoItem[indexPath.row].done == false {
            toDoItem[indexPath.row].done = true
        } else { toDoItem[indexPath.row].done = false }*/
        // Update the information
        self.saveItems()
        // unselected the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.presentAnAlert(titleAlert: "Add new todey item", titleAlertAction: "Add a item", titleCancel: "Cancelar")
    }
    
    //MARK: - My Functions
    func presentAnAlert(titleAlert title: String, titleAlertAction titleAction: String, titleCancel: String) {
        // variable al alcance de toda la funcion
        var textField = UITextField()
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: titleAction, style: .default) { (action) in
            
            // what will happen once the user clicks the Add item action on our UIAlert
            
            let newItem = Item(context: self.MyNSContext)
            newItem.toDoTitle = textField.text!
            newItem.done = false
            self.toDoItem.append(newItem)
            self.saveItems()  // we can save our data
            
        }
        
        // this closure only actives when the textfield added to the alert
        alert.addTextField { (myTextFieldAlert) in  // local variable ONLY inside this closure
            myTextFieldAlert.placeholder = "Create new Item"
            textField = myTextFieldAlert
            /*de esta forma el texto añadido se lo pasamos
             a textField ya que es una variable local
             al alcance de toda la funcion */
        }
        
        let cancel = UIAlertAction(title: titleCancel, style: .cancel) { (actionCancel) in
            return
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        do {
            try MyNSContext.save()
        } catch {
            print("Error saving data \(error)")
        }
        // Update the table
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let NSRequest: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            toDoItem = try MyNSContext.fetch(NSRequest)
        } catch {
            print("Error fetching data from context \(error)")
        }
        /* // Save data with NSCoder
        if let data = try? Data(contentsOf: NSDataFieldPath!) {
            let decoder = PropertyListDecoder()
            do {
                toDoItem = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding Data \(error)")
            }
        }*/
    }
    
}
