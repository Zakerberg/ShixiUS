//
//  AppDelegate.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我爱你
 사랑해
 jet'aime
 tequiero
 ichliebe dich
 eute amo
 tiamo
 爱している
 */

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarVC: SX_TabBarController?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame:SCREEN_BOUNDS)
        self.window?.backgroundColor = UIColor.white
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        IQKeyboardManager.shared.enableAutoToolbar = false
//        if !UserDefaults.standard.bool(forKey: "firstLaunch") {
//            UserDefaults.standard.bool(forKey: "firstLaunch")
//            SXLog("首次启动")
//            let gVC = SX_GuideViewController()
//            self.window?.rootViewController = gVC
//        }else{
            self.window?.rootViewController = SX_TabBarController()
//        }
        setNavBarAppearence()
        USERDEFAULTS.set("no", forKey: "login")
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
// =====================================================================================================
// MARK: - setNavBarAppearence ! ! !
// =====================================================================================================
    func setNavBarAppearence() {
        // 设置导航栏默认的背景颜色
        SX_NavigationBar.defaultNavBarBarTintColor = UIColor.SX_MainColor()
        // 设置导航栏所有按钮的默认颜色
        SX_NavigationBar.defaultNavBarTintColor    = .white
        // 设置导航栏标题默认颜色
        SX_NavigationBar.defaultNavBarTitleColor   = .white
        // 统一设置状态栏样式
        SX_NavigationBar.defaultStatusBarStyle     = .default
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        SX_NavigationBar.defaultShadowImageHidden  = true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ShixiUS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /// open URL
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let alertController = UIAlertController(title: "将此文件作为简历上传到实习网?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
         
        })
        
        let sureAction  = UIAlertAction(title: "确定", style: .default, handler: { (action) in
            SXLog("这里的! ! ! ! ! ---> url=\(url)")
            
            
            
            
            
            

        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(sureAction)
        
        self.window!.rootViewController?.present(alertController, animated: true, completion: {
        })
        
        return true
    }
}
