//
//  Persons.swift
//  challenge
//
//  Created by Karim Dalaize on 27/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import Foundation

struct Person: Codable {

    struct Name: Codable {
        let first: String
        let last: String
    }
    struct Location: Codable {
        let street: String
        let city: String
        let state: String
//        let postcode: Int
    }
    struct Avatar: Codable {
        let thumbnail: String
    }
    struct DateOfBirth: Codable {
        let date: String
        let age: Int
    }
    let name: Name
    let location: Location
    let email: String
    let picture: Avatar
    let dob: DateOfBirth
    let phone: String
    let cell: String
    
}

struct Persons: Codable {
    var results: [Person]
}
