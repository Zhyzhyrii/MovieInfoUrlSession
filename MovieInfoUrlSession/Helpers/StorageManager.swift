//
//  StorageManager.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/31/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let storageManager = StorageManager()
    
    private var user: User?
    private let defaults = UserDefaults.standard
    
    func getUser() -> User? {
        guard let savedUser = defaults.object(forKey: "savedUser") as? Data else { return nil}
        guard let fetchedUser = try? JSONDecoder().decode(User.self, from: savedUser) else { return nil }
        user = fetchedUser
        return user
    }
    
    func saveUser(_ user: User) {
        guard let userEncoded = try? JSONEncoder().encode(user) else { return }
        defaults.set(userEncoded, forKey: "savedUser")
    }
    
}
