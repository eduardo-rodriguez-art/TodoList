//
//  TodoeyTableViewController.swift
//  APP-TodoeyList
//
//  Created by José Eduardo Rodríguez Reyes on 25/07/21.
//

import UIKit
//* Estudiar secuencia de eventos
class TodoeyTableViewController: UITableViewController {

    var daysOfWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday", "Sunday"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todoey List"
                // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //Add a section for each day
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        //let days = daysOfWeek[indexPath.row]
        cell.textLabel?.text = daysOfWeek[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    } */
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    //MARK: - Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Add a checkmark to each cell
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else { // Unmark and mark each cell
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // unselected the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.presentAnAlert(titleAlert: "Add new todey item", titleAlertAction: "Add a item")
    }
    
    //MARK: - My Functions
    func presentAnAlert(titleAlert title: String, titleAlertAction titleAction: String) {
        // variable al alcance de toda la funcion
        var textField = UITextField()
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: titleAction, style: .default) { (action) in
            // what will happen once the user clicks the Add item action on our UIAlert
            if textField.text != nil {
                self.daysOfWeek.append(textField.text ?? "")
                self.tableView.reloadData()
            } else {
                print("Nothing were add")
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
