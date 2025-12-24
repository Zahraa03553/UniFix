//
//  SceneDelegate.swift
//  UniFix
//
//  Created by zahraa humaidan on 12/12/2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
     //   window = UIWindow (windowScene: windowScene)
      //  let defaults = UserDefaults.standard.bool(forKey:"hasLunchedBefore")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Check if user ID exists in UserDefaults
       // if let userID = UserDefaults.standard.string(forKey: //UserDefaultsKeys.userlD),
        
        
            Auth.auth().addStateDidChangeListener{ auth, user in
            // User is logged in - show Home screen
            if  user != nil{
                guard let userId = Auth.auth().currentUser?.uid else {return}
                Firestore.firestore().collection("users").document(userId).getDocument {
                    snapshot, error in
                    if let data = snapshot?.data(),
                       let userType = data["userType"] as? String {
                        if userType == "student" {
                            
                            let studentTB  = storyboard.instantiateViewController(withIdentifier: "StudehtTsbBar") as? UITabBarController
                            
                            self.window?.rootViewController = studentTB
                               self.window?.makeKeyAndVisible()
                            
                            
                        }
                        if userType == "admin" {
                            
                            let adminTB  = storyboard.instantiateViewController(withIdentifier: "adminTB") as? UITabBarController
                            
                            self.window?.rootViewController = adminTB
                              self.window?.makeKeyAndVisible()
                        }
                        if userType == "maintenanceTeam" {
                            let maintenanceTB  = storyboard.instantiateViewController(withIdentifier: "goToMaintenanceDashboard") as? UITabBarController
                            self.window?.rootViewController = maintenanceTB
                            self.window?.makeKeyAndVisible()

                        }
                            
                        }
                    }
                
            } else  if !UserDefaults.standard.bool(forKey:"hasLunchedBefore") {
                self.showWelcome()
            } else {
                self.showLogin()
                

            }
            
        }

        
    }
       
   
    func showWelcome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeVC =
        storyboard.instantiateViewController(withIdentifier:"welcomeNB") as? UINavigationController
        self.window?.rootViewController = welcomeVC
        self.window?.makeKeyAndVisible()
        UserDefaults.standard.set(true, forKey: "hasLunchedBefore")
    }
        
    func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC =  storyboard.instantiateViewController(withIdentifier:"loginNB") as? UINavigationController
        self.window?.rootViewController = loginVC
        self.window?.makeKeyAndVisible()
    }
              
            
        
    
    
   
        func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            // Called when the scene has moved from an inactive state to an active state.
            // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
            
            // Save changes in the application's managed object context when the application transitions to the background.
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        
    }
    

