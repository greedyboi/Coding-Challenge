//
//  Person.swift
//  challenge
//
//  Created by Karim Dalaize on 25/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit

class Person {
    //MARK: Properties
    var name: String
    var avatar: UIImage?
    var email: String
    
    //MARK: Initialization
    init?(name: String, email: String, avatar: UIImage?) {
        if name.isEmpty || email.isEmpty {
            return nil
        }

        self.name = name
        self.email = email
        self.avatar = avatar        
    }
}
