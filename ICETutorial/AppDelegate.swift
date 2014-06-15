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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()

        // Init the pages texts, and pictures.
        var layer1: ICETutorialPage = ICETutorialPage(title: "Picture 1", subTitle: "Champs-Elysées by night", pictureName: "tutorial_background_00@2x.jpg", duration: 3.0)
        var layer2: ICETutorialPage = ICETutorialPage(title: "Picture 2", subTitle: "The Eiffel Tower with\n cloudy weather", pictureName: "tutorial_background_01@2x.jpg", duration: 3.0)
        var layer3: ICETutorialPage = ICETutorialPage(title: "Picture 3", subTitle: "An other famous street of Paris", pictureName: "tutorial_background_02@2x.jpg", duration: 3.0)
        var layer4: ICETutorialPage = ICETutorialPage(title: "Picture 4", subTitle: "The Eiffel Tower with a better weather", pictureName: "tutorial_background_03@2x.jpg", duration: 3.0)
        var layer5: ICETutorialPage = ICETutorialPage(title: "Picture 5", subTitle: "The Louvre's Museum Pyramide", pictureName: "tutorial_background_04@2x.jpg", duration: 3.0)
        
        // Set the common style for SubTitles and Description (can be overrided on each page).
        var titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        titleStyle.font = UIFont(name: "Helvetica-Bold", size: 17.0)
        titleStyle.color = UIColor.whiteColor()
        titleStyle.linesNumber = 1
        titleStyle.offsset = 180
        
        var subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        subStyle.font = UIFont(name: "Helvetica", size: 15.0)
        subStyle.color = UIColor.whiteColor()
        subStyle.linesNumber = 1
        subStyle.offsset = 150
        
        
        var listPages: ICETutorialPage[] = [layer1, layer2, layer3, layer4, layer5]
        
        var controller: ICETutorialController = ICETutorialController(pages: listPages)
        controller.commonPageTitleStyle = titleStyle
        controller.commonPageSubTitleStyle = subStyle
        controller.startScrolling()

        self.window!.rootViewController = controller
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

