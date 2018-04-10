//
//  NetworkManager.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import Foundation

class NetworkManager {
    
    typealias UserDataCompletionBlock = ([User]?, String) -> ()
    typealias JSONDictionary = [String: Any]
    
    var users: [User] = []
    var errorMessage = ""
    
    var dataTask: URLSessionDataTask?
    var matchEndpoint = "https://www.okcupid.com/matchSample.json"
    
    func fetchUserData(completion: @escaping UserDataCompletionBlock) {
        dataTask?.cancel()
        
        guard let url = URL(string: matchEndpoint) else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage += "DataTask error: \(error.localizedDescription)\n"
            } else if let data = data {
                self.serializeJSON(data)
                
                DispatchQueue.main.async {
                    completion(self.users, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
    
    private func serializeJSON(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let userArray = response!["data"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        for user in userArray {
            if let userDictionary = user as? JSONDictionary,
                let username = userDictionary["username"] as? String,
                let age = userDictionary["age"] as? Int,
                let matchPercentage = userDictionary["match"] as? Int,
                let locationDict = userDictionary["location"] as? JSONDictionary,
                let imageDict = userDictionary["photo"] as? JSONDictionary {
                
                guard let location = parseLocationJSON(dictionary: locationDict) else { return }
                guard let image = parseImageJSON(dictionary: imageDict) else { return }
                
                let newUser = User(username: username, age: age, matchPercentage: matchPercentage, location: location, profileImage: image)
                users.append(newUser)
            } else {
                errorMessage += "Issue parsing matchSample 💔\n"
            }
        }
    }
    
    private func parseLocationJSON(dictionary: JSONDictionary) -> Location? {
        guard let countryName = dictionary["country_name"] as? String,
            let countryCode = dictionary["country_code"] as? String,
            let stateName = dictionary["state_name"] as? String,
            let stateCode = dictionary["state_code"] as? String,
            let cityName = dictionary["city_name"]  as? String  else {
                return nil
        }
        
        let locationObject = Location(countryName: countryName,
                                      countryCode: countryCode,
                                      stateName: stateName,
                                      stateCode: stateCode,
                                      cityName: cityName)
        
        return locationObject
    }
    
    private func parseImageJSON(dictionary: JSONDictionary) -> ProfileImage? {
        guard let urlDictionary = dictionary["full_paths"] as? JSONDictionary,
            let largeImageString = urlDictionary["large"] as? String,
            let largeImageURL = URL(string: largeImageString),
            let smallImageString = urlDictionary["small"] as? String,
            let smallImageURL = URL(string: smallImageString),
            let mediumImageString = urlDictionary["small"] as? String,
            let mediumImageURL = URL(string: mediumImageString),
            let originalImageString = urlDictionary["original"] as? String,
            let originalImageURL = URL(string: originalImageString) else {
                return nil
        }
        
        let imageObject = ProfileImage(largeImageURL: largeImageURL,
                                       smallImageURL: smallImageURL,
                                       mediumImageURL: mediumImageURL,
                                       originalImageURL: originalImageURL)
        
        return imageObject
    }
}









