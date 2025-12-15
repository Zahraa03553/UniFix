//
//  SettingsViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 15/12/2025.
//

import UIKit
import FirebaseAuth
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let user = Auth.auth().currentUser {
            print("Signed in user: \(user.uid)")
        }
    }
    
    @IBAction func signOutAction(_ sender: UIButton) {
        
        showAlertConform()
    }
  func signOut() {
            
        
        do {
            try Auth.auth().signOut()
        navigateToLogin()
    }catch let error{
        showAlert(title: "Sign Out Failed ", message: error.localizedDescription)
    }
    }
    func navigateToLogin() {
        guard let scene  = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let SceneDelegate = scene.delegate as? SceneDelegate,
              let window = SceneDelegate.window else {
            return
        }
        
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let loginVC =
            storyboard.instantiateViewController(withIdentifier:
            "LoginViewController")
        window.rootViewController = loginVC
                window.makeKeyAndVisible()
            }
    
func showAlertConform(){
    let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
   let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
       print("Cancel")
    }
    let  OKAction = UIAlertAction(title: "Yes", style: .default) {  _ in
        self.signOut()
    }
    alert.addAction(cancelAction)
    alert.addAction(OKAction)
    present(alert, animated: true)
}
    func showAlert(title: String, message: String) {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true)
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
