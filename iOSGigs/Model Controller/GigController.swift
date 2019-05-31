//
//  GigController.swift
//  iOSGigs
//
//  Created by Seschwan on 5/30/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import Foundation

enum RequestSetValue: String {
    case applicationJson = "application/json"
    case forHTTPHeaderField = "Content-Type"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}

class GigController {
    // Creating an array of [Gigs]
    var gigArray: [Gig] = []
    // Creating a token/bearer variable
    var bearer: Bearer?
    // Setting the Base URL for the API calls
    private let baseURL = URL(string: "https://lambdagigs.vapor.cloud/api")!
    
    func signUp(with user: User, completetion: @escaping (Error?) -> ()) {
        // Adding "users/signup" to the end of the baseURL
        let signUpURL = baseURL.appendingPathComponent("users/signup")
        
        // Create a request with signUpURL
        var request = URLRequest(url: signUpURL)
        // Setting the request httpMethod to "POST"
        request.httpMethod = HTTPMethod.post.rawValue
        // Setting the header value and type?
        request.setValue(RequestSetValue.applicationJson.rawValue, forHTTPHeaderField: RequestSetValue.forHTTPHeaderField.rawValue)
        
        let jsonEncoder = JSONEncoder() // Create a new JSONEncoder() instance
        
        do {
            let jsonData = try jsonEncoder.encode(user) // Trying to encode the user data into JSON Data
            request.httpBody = jsonData // Setting the messageBody to the JSON Data that was just encoded
        } catch { // Catching the error
            NSLog("Error encoding user object: \(error)")  // Logging the error
            completetion(error)  // @escaping out of the function
            return  // returning
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in // Click on URLSession
            if let response = response as? HTTPURLResponse, // Checking the response code
                response.statusCode != 200 {
                completetion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completetion(error)
                return
            }
            completetion(nil)
        }.resume()
    }
    
    func signIn(with user: User, completion: @escaping (Error?) -> ()) {
        let loginURL = baseURL.appendingPathComponent("users/login")
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(RequestSetValue.applicationJson.rawValue, forHTTPHeaderField: RequestSetValue.forHTTPHeaderField.rawValue)
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
            } catch {
                NSLog("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            completion(nil)
            
        }.resume()
        
    }
    
    func getAllGigs(completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer else {
            completion(NSError())
            return
        }
        let allGigsURL = baseURL.appendingPathComponent("gigs")
        var request = URLRequest(url: allGigsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(error)
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let allGigs = try decoder.decode([Gig].self, from: data)
                completion(nil)
            } catch {
                NSLog("Error decoding Gigs: \(error)")
                completion(error)
                return
            }
        }.resume()
        
    }
    
    func createAGig(gig: Gig, completion: @escaping (Error?) -> ()) {
        guard let bearer = bearer else {
            NSLog("No bearer token")
            completion(NSError())
            return
        }
        
        let createGigURL = baseURL.appendingPathComponent("gigs")
        var request = URLRequest(url: createGigURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(RequestSetValue.applicationJson.rawValue, forHTTPHeaderField: RequestSetValue.forHTTPHeaderField.rawValue)  // Body of the request is JSON
        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization") //Needed to authenticate with API
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        
        do {
            let gig = try jsonEncoder.encode(gig)
        } catch {
            NSLog("Error trying to encode gig: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                NSLog("Error decoding bearer: \(error)")
                completion(error)
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            self.gigArray.append(gig) // If a success then we are adding to our gigArray
        }.resume()
        
        
    }
    
}
