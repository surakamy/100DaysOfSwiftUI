//
//  SceneDelegate.swift
//  Trekopedia
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import UIKit
import SwiftUI


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var app: AppDelegate { (UIApplication.shared.delegate as! AppDelegate) }



    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        let contentView = ContentView()
                .environment(\.managedObjectContext, self.app.trekopediaContainer.viewContext)

            // Use a UIHostingController as window root view controller.
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: contentView)
                self.window = window
                window.makeKeyAndVisible()
            }

        // Create the SwiftUI view that provides the window contents.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        app.saveContext()
    }

}

