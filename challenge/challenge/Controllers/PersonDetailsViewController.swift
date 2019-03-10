//
//  PersonDetailsViewController.swift
//  challenge
//
//  Created by Karim Dalaize on 26/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit

class PersonDetailsViewController: UIViewController {
    //MARK: Properties
    var person: Person?
    
    @IBOutlet var userAvatar: UIImageView!
    @IBOutlet var nameValue: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var state: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var cell: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var dob: UILabel!
    @IBOutlet var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameValue.text = (person?.name.first.capitalized)! + " " + (person?.name.last.capitalized)!
        address.text = person?.location.street.capitalized
        city.text = person?.location.city.capitalized
        state.text = person?.location.state.capitalized
        email.text = person?.email
        phone.text = person?.phone
        cell.text = person?.cell
        
        favButton.setTitle((Storage.checkIfFav(person!) > -1 ? "Unfavorite" : "Add to Favorites"), for: UIControl.State.normal)
        favButton.accessibilityIdentifier = Storage.checkIfFav(person!) > -1 ? "RemoveFromFav" : "AddToFav"
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func favToggle(_ sender: UIButton) {
        if sender.accessibilityIdentifier == "AddToFav" {
            Storage.inFav(person!)
            favButton.setTitle("Unfavorite", for: UIControl.State.normal)
            sender.accessibilityIdentifier = "RemoveFromFav"
        } else if sender.accessibilityIdentifier == "RemoveFromFav" {
            Storage.removeFromFavorites(person!)
            favButton.setTitle("Add to Favorites", for: UIControl.State.normal)
            sender.accessibilityIdentifier = "AddToFav"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
