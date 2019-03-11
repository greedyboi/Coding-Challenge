//
//  FavoritesTableViewController.swift
//  challenge
//
//  Created by Karim Dalaize on 05/03/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    var favorites = Persons(results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PersonTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PersonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PersonTableViewCell.")
        }
        
        let person = favorites.results[indexPath.row]
        
        cell.nameLabel.text = person.name.first.capitalized + " " + person.name.last.capitalized
        cell.emailLabel.text = person.email
        
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        favorites = Storage.load()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let detailViewController = segue.destination
                as! PersonDetailsViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            detailViewController.person = favorites.results[row]
        }
    }
    


}
