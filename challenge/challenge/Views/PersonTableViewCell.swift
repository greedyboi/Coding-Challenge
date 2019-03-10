//
//  PersonTableViewCell.swift
//  challenge
//
//  Created by Karim Dalaize on 25/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    //MARK: Properties
    var person: Person!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet var favButton: UIButton!
    //@IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        // Initialization code
        
        super.awakeFromNib()
        
        nameLabel.text = person.name.first.capitalized + " " + person.name.last.capitalized
        emailLabel.text = person.email
        favButton.setTitle((Storage.checkIfFav(person!) > -1 ? "Unfavorite" : "Add to Favorites"), for: UIControl.State.normal)
        favButton.accessibilityIdentifier = Storage.checkIfFav(person!) > -1 ? "RemoveFromFav" : "AddToFav"
    }

    //MARK: Actions
    @IBAction func toggleFav(_ sender: UIButton) {
        self.
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
