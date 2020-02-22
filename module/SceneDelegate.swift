//
//  SceneDelegate.swift
//  module
//
//  Created by The Remedy on 19/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last as! String)
//
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("When the app is disconnected")  }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("When the app becomes active")  }

    func sceneWillResignActive(_ scene: UIScene) {
       print("When the app resigns from being active")
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
        print("When the app enter foreground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
         print("When the app enters the background")
          }

}

