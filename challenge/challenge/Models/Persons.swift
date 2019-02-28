//
//  Persons.swift
//  challenge
//
//  Created by Karim Dalaize on 27/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import Foundation

struct Persons: Decodable {
    struct Person: Decodable {
        struct Name: Decodable {
            let first: String
            let last: String
        }
        struct Avatar: Decodable {
            let thumbnail: String
        }
        
        let name: Name
        let email: String
        let picture: Avatar
    }
    var results: [Person]
}
