//
//  SceneDelegate.swift
//  module
//
//  Created by The Remedy on 19/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("When the app is disconnected")  }

    func sceneWillResignActive(_ scene: UIScene) {
       print("When the app resigns from being active")
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
         print("When the app enters the background")
          }


}

