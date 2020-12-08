//
//  AppDelegate.swift
//  Trekopedia
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    lazy var trekopediaStoreDescriptions: [NSPersistentStoreDescription] = {
        ["pedia", "user_data"].compactMap { name in
            Bundle.main.path(forResource: name, ofType: "sqlite")
        }.map { path in
            URL(fileURLWithPath: path)
        }.map { url in
            let storeDescription = NSPersistentStoreDescription(url: url)
            //storeDescription.isReadOnly = true
            storeDescription.shouldMigrateStoreAutomatically = true
            storeDescription.shouldInferMappingModelAutomatically = true
            return storeDescription
        }
    }()

    lazy var trekopediaContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "trekopedia")

        container.persistentStoreDescriptions = trekopediaStoreDescriptions

        container.loadPersistentStores { description, error in
            if let error = error { fatalError(error.localizedDescription) }
        }
        return container
    }()

    func saveContext() {
        let context = trekopediaContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

            }
        }
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = trekopediaContainer
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

