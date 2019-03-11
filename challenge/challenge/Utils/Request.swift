//
//  Request.swift
//  challenge
//
//  Created by Karim Dalaize on 27/02/2019.
//  Copyright © 2019 Karim Dalaize. All rights reserved.
//

import UIKit

class Request {
    typealias QueryResult = (Persons?, String) -> ()
    
    var errorMessage = ""
    var persons = Persons(results: [])
    
    func fetchData(_ page: Int, completion: @escaping QueryResult) {
        let url = URL(string: "https://randomuser.me/api/?results=10&page=" + String(page) + "&seed=challenge")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.errorMessage += "Client Error: " + error.localizedDescription
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    self.errorMessage += "Server Error"
                    return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
                let data = data {
                print(data)
                let json = try? JSONDecoder().decode(Persons.self, from: data)
                self.updateData(json: json!)
                DispatchQueue.main.async {
                    completion(self.persons, self.errorMessage)
                }
            }
        }
        task.resume()
    }
    
    private func updateData(json: Persons) {
        persons.results.removeAll()
        persons = json
    }
}
