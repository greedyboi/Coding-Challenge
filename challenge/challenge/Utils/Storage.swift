//
//  Storage.swift
//  challenge
//
//  Created by Karim Dalaize on 05/03/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit

public class Storage {
    
    static fileprivate func getDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access the directory")
        }
    }
    
    // save selected person to favorites list
    static func inFav(_ person: Person) {
        let url = getDirectory().appendingPathComponent("favorites", isDirectory: false)
        
        let encoder = JSONEncoder()
        
        do {
            var favorites = load()
            
            for item in favorites.results {
                if item.email == person.email {
                    return ;
                }
            }
            
            favorites.results.append(person)
            let data = try encoder.encode(favorites)
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Load the favorites list
    static func load () -> Persons {
        let url = getDirectory().appendingPathComponent("favorites", isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            return Persons(results: [])
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(Persons.self, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    
    // remove from favorite list
    static func removeFromFavorites(_ person: Person) {
        let index = checkIfFav(person)
        if index > -1 {
            do {
                var favorites = load()
                let encoder = JSONEncoder()
                let url = getDirectory().appendingPathComponent("favorites", isDirectory: false)
                
                favorites.results.remove(at: index)
                let data = try encoder.encode(favorites)
                
                if FileManager.default.fileExists(atPath: url.path) {
                    try FileManager.default.removeItem(at: url)
                    FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // check if the selected person is already in favorite list
    static func checkIfFav(_ person: Person) -> Int {
        let favorites = load()
        
        for (index, value) in favorites.results.enumerated() {
            if value.email == person.email {
                return index
            }
        }
        return -1
    }
}
