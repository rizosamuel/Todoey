//
//  AppDelegate.swift
//  Todoey
//
//  Created by Rijo Samuel on 21/12/21.
//

import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		/// Override point for customization after application launch.
		print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
		return true
	}

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		
		/// Called when a new scene session is being created.
		/// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		
		/// Called when the user discards a scene session.
		/// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		/// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		saveContext()
	}
	
	// MARK: - Core Data stack
	lazy var persistentContainer: NSPersistentContainer = {
		
		let container = NSPersistentContainer(name: "DataModel")
		
		container.loadPersistentStores { storeDescription, error in
			
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		
		return container
	}()
	
	// MARK: - Core Data Saving support
	func saveContext() {
		
		guard persistentContainer.viewContext.hasChanges else { return }
		
		do {
			try persistentContainer.viewContext.save()
		} catch {
			let nserror = error as NSError
			fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}
}
