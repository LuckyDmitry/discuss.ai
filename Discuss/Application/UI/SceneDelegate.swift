//
//  SceneDelegate.swift
//  NudeFilterML
//
//  Created by Osaretin Uyigue on 8/22/20.
//  Copyright © 2020 Osaretin Uyigue. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  private var screens: Screens?
  
  var window: UIWindow?
  
  @available(iOS 13.0, *)
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    let services = Services.services
    services.window = window
    let screens = Screens(services: services)
  
    setupAppearence()
    self.screens = screens
    self.window = window
    window.windowScene = windowScene
    
    services.screenNavigator.navigate(to: screens.showSplashRoute())
  }
  
  private func setupAppearence() {
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithOpaqueBackground()
//    navBarAppearance.backgroundColor = .black
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    UINavigationBar.appearance().standardAppearance = navBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    UINavigationBar.appearance().tintColor = .black
    
    UITabBar.appearance().barTintColor = .black
    UITabBar.appearance().isTranslucent = true
    
    if #available(iOS 15.0, *) {
      let appearance = UITabBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .white
      UITabBar.appearance().standardAppearance = appearance
      UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
  }
}
