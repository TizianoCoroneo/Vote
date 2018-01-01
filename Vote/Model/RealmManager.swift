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

    static let shared = RealmManager()

    fileprivate(set) var defaultRealm: Realm?

    private let localRealmURL = URL(string: "realm://192.168.178.165:9080/~/voteTest")!
    
    fileprivate var config = Realm.Configuration()

    fileprivate init() {
        defaultRealm = createRealm()
    }

    func eraseAll() {
        do {
            guard let r = defaultRealm else { return }
            try r.write {
                r.deleteAll()
            }
        } catch {
            let nserror = error as NSError
            Crashlytics.sharedInstance().recordError(nserror)
        }
    }

    func createRealm(_ completion: ((Realm?) throws -> ())? = nil) -> Realm? {
        
        if let user = SyncUser.current {
            config.syncConfiguration = SyncConfiguration.init(
                user: user,
                realmURL: localRealmURL)
            
            do {
                return try Realm.init(configuration: config)
            } catch {
                print("error = \(error)")
            }
        } else {
            let creds =
                SyncCredentials.usernamePassword(
                    username: "realm-admin",
                    password: "")
            
            SyncUser.logIn(
                with: creds,
                server: localRealmURL,
                onCompletion: {
                    [weak self, localRealmURL]
                    user, error in
                    guard let `self` = self else { return }
                    guard let user = user else {
                        print("error = \(error?.localizedDescription ?? "nil")")
                        return
                    }
                    
                    let syncConfig = SyncConfiguration.init(
                        user: user,
                        realmURL: localRealmURL)
                    let newConfig = Realm.Configuration.init(
                        syncConfiguration: syncConfig)
                    do {
                        self.defaultRealm = try Realm.init(configuration: newConfig)
                        try completion?(self.defaultRealm)
                    } catch {
                        print("error = \(error)")
                    }
            })
            return nil
        }
        return nil
    }
    
    func fetchAll<T: Object>() -> [T] {
        guard let r = defaultRealm else { return [] }
        return Array(r.objects(T.self))
    }

}

extension Object {

    fileprivate func realmInst() -> Realm? {
        return self.realm ?? RealmManager.shared.defaultRealm
    }

    /** Must be called from main thread */
    func save(_ update: Bool = true) throws {
        guard let realm = self.realmInst() else { return }
        try realm.write() {
            realm.add(self, update: update)
        }
    }

    /** Must be called from main thread */
    static func save(_ objects: [Object], update: Bool = true) throws {
        guard let first = objects.first else {
            return
        }
        guard let realm = first.realmInst() else { return }
        try realm.write() {
            objects.forEach() { realm.add($0, update: update) }
        }
    }
}
