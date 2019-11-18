//
//  RealmManager.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/18/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    private static let realm = try! Realm()
    
    static func addObject(object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    static func updateObject(closure: () -> ()) {
        do {
            try realm.write {
                closure()
            }
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
}
