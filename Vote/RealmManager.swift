//
//  RealmManager.swift
//  Vote
//
//  Created by Tiziano Coroneo
//  Copyright © 2016 Tiziano Coroneo. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics
import RealmSwift

class RealmManager {

    static let sharedInstance = RealmManager()

    fileprivate(set) var defaultRealm: Realm!

    fileprivate var config = Realm.Configuration()

    fileprivate init() {
        do {
            defaultRealm = try Realm(configuration: config)
            debugPrint("Realm DB path: \(config.fileURL?.absoluteString ?? "nil")")
        } catch {
            let nserror = error as NSError
            Crashlytics.sharedInstance().recordError(nserror)
        }
    }

    func eraseAll() {
        do {
            let realm = try createRealm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            let nserror = error as NSError
            Crashlytics.sharedInstance().recordError(nserror)
        }
    }

    func createRealm() throws -> Realm {
        return try Realm(configuration: config)
    }

}

extension Object {

    fileprivate func realmInst() -> Realm {
        return self.realm ?? RealmManager.sharedInstance.defaultRealm
    }

    /** Must be called from main thread */
    func save(_ update: Bool = true) throws {
        let realm = self.realmInst()
        try realm.write() {
            realm.add(self, update: update)
        }
    }

    /** Must be called from main thread */
    static func save(_ objects: [Object], update: Bool = true) throws {
        guard let first = objects.first else {
            return
        }
        let realm = first.realmInst()
        try realm.write() {
            objects.forEach() { realm.add($0, update: update) }
        }
    }
    
}
