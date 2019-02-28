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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    //@IBOutlet weak var avatarImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
