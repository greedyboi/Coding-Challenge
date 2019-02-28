//
//  PersonTableViewController.swift
//  challenge
//
//  Created by Karim Dalaize on 26/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    //MARK: Proporties
    
    var persons = Persons(results: [])
    var request = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load persons
        fetchPersons()
        print(persons.results.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PersonTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PersonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PersonTableViewCell.")
        }
        
        let person = persons.results[indexPath.row]
        
        cell.nameLabel.text = person.name.first.capitalized + " " + person.name.last.capitalized
        cell.emailLabel.text = person.email

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    
    private func fetchPersons() {
        request.fetchData() { results, errorMessage in
            if let results = results {
                self.persons = results
                self.tableView.reloadData()
            }
            if !errorMessage.isEmpty {
                NSLog("Got a Network error: %s", errorMessage)
                let alert = UIAlertController(title: "Network Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "Default action"), style: .default, handler: { _ in
                    NSLog(errorMessage)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
