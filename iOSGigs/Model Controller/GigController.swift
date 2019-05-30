//
//  GigController.swift
//  iOSGigs
//
//  Created by Seschwan on 5/30/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import Foundation

enum RequestSetValue: String {
    case setValue = "application/json"
    case forHTTPHeaderField = "Content-Type"
}

class GigController {
    var gigArray: [Gig] = []
    var bearer: Bearer?
    private let baseURL = "https://lambdagigs.vapor.cloud/api"
    
    func signUp(with user: User, completetion: @escaping (Error?) -> ()) {
        
    }
    
    
    
}
