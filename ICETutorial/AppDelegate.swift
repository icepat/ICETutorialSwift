//
//  AppDelegate.swift
//  ICETutorial
//
//  Created by Patrick Trillsam on 5/06/2014.
//  Copyright (c) 2014 Patrick Trillsam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        // Override point for customization after application launch.

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = .white
        
        // Init the pages texts, and pictures.
        let layer1 = ICETutorialPage(title: "Picture 1", subTitle: "Champs-Elysées by night", pictureName: "tutorial_background_00@2x.jpg", duration: 3.0)
        let layer2 = ICETutorialPage(title: "Picture 2", subTitle: "The Eiffel Tower with\n cloudy weather", pictureName: "tutorial_background_01@2x.jpg", duration: 3.0)
        let layer3 = ICETutorialPage(title: "Picture 3", subTitle: "An other famous street of Paris", pictureName: "tutorial_background_02@2x.jpg", duration: 3.0)
        let layer4 = ICETutorialPage(title: "Picture 4", subTitle: "The Eiffel Tower with a better weather", pictureName: "tutorial_background_03@2x.jpg", duration: 3.0)
        let layer5 = ICETutorialPage(title: "Picture 5", subTitle: "The Louvre's Museum Pyramide", pictureName: "tutorial_background_04@2x.jpg", duration: 3.0)
        
        // Set the common style for SubTitles and Description (can be overrided on each page).
        let titleStyle = ICETutorialLabelStyle()
        titleStyle.font = .boldSystemFont(ofSize: 17)
        titleStyle.color = .white
        titleStyle.linesNumber = 1
        titleStyle.offset = 180
        
        let subStyle = ICETutorialLabelStyle()
        subStyle.font = .systemFont(ofSize: 15)
        subStyle.color = .white
        subStyle.linesNumber = 1
        subStyle.offset = 150
        
        let listPages = [layer1, layer2, layer3, layer4, layer5]
        
        let controller = ICETutorialController(pages: listPages)
        controller.commonPageTitleStyle = titleStyle
        controller.commonPageSubTitleStyle = subStyle
        controller.startScrolling()
        
        self.window!.rootViewController = controller
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

