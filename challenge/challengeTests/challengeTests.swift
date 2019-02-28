//
//  challengeTests.swift
//  challengeTests
//
//  Created by Karim Dalaize on 25/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import XCTest
@testable import challenge

class challengeTests: XCTestCase {

    //MARK: Person Class Tests
    func testPersonInitializationSucceeds() {
        let person1 = Person.init(name: "Person1", email: "person1@test.com", avatar: nil)
        XCTAssertNotNil(person1)
        
        let person2 = Person.init(name: "Person2", email: "person2@test.com", avatar: nil)
        XCTAssertNotNil(person2)
    }
    
    func testPersonInitializationFails() {
        let emptyNamePerson = Person.init(name: "", email: "empty@name.com", avatar: nil)
        XCTAssertNil(emptyNamePerson)
        
        let emptyEmailPerson = Person.init(name: "Empty Email", email: "", avatar: nil)
        XCTAssertNil(emptyEmailPerson)
    }
    
    
}
