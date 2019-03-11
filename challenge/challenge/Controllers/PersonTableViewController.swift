//
//  PersonTableViewController.swift
//  challenge
//
//  Created by Karim Dalaize on 26/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit
import SDWebImage

class PersonTableViewController: UITableViewController {
    //MARK: Proporties
    
    var persons = Persons(results: [])
    var request = Request()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshPersonsData(_:)), for: .valueChanged)
        
        self.refreshControl = refreshControl
        //Load persons
        fetchPersons(page)
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
        
        if self.tableView(self.tableView, numberOfRowsInSection: 0) > 0 {
            if indexPath.row == persons.results.count - 1 {
                self.page += 1
                fetchPersons(self.page)
            }
            let person = persons.results[indexPath.row]
            
            cell.nameLabel.text = person.name.first.capitalized + " " + person.name.last.capitalized
            cell.emailLabel.text = person.email
            if Storage.checkIfFav(person) == -1 {
                cell.favButton.setTitle("Add to Favorites", for: UIControl.State.normal)
                cell.favButton.accessibilityIdentifier = "AddToFav"
            } else {
                cell.favButton.setTitle("Unfavorite", for: UIControl.State.normal)
                cell.favButton.accessibilityIdentifier = "RemoveFromFav"
            }
            cell.buttonTap = { cell in
                if Storage.checkIfFav(person) == -1 {
                    Storage.inFav(person)
                } else {
                    Storage.removeFromFavorites(person)
                }
                self.tableView.reloadData()
            }
            //cell.avatarImage.sd_setImage(with: URL(string: person.picture.thumbnail))
        }
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            
            let detailViewController = segue.destination
                as! PersonDetailsViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            detailViewController.person = persons.results[row]
        } else if segue.identifier == "ShowFavorites" {
            
            let favoritesViewController = segue.destination as! FavoritesTableViewController
            favoritesViewController.favorites = Storage.load()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    //MARK: Private Methods
    @objc private func refreshPersonsData(_ sender: Any) {
        // Fetch Persons Data
        self.persons.results = []
        self.page = 1
        fetchPersons(1)
        self.refreshControl!.endRefreshing()
    }
    
    private func fetchPersons(_ page: Int) {
        request.fetchData(page) { results, errorMessage in
            if let results = results {
                self.persons.results += results.results
                self.tableView.reloadData()
            }
            if !errorMessage.isEmpty {
                print("Got a Network error: %s", errorMessage)
                let alert = UIAlertController(title: "Network Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "Default action"), style: .default, handler: { _ in
                    NSLog(errorMessage)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
