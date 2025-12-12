//
//  LoginViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 12/12/2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.animateGradient(colors: [UIColor.primaryDarkGrey,UIColor.primaryGrey])
    }
   func shoeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    
    guard let email = emailTxt.text, !email.isEmpty else {
            shoeAlert(title: "Error", message: "Please enter email")
            return
        }
        guard let password = passwordTxt.text, !password.isEmpty else {
            shoeAlert(title: "Error", message: "Please enter password")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            if let error = error {
                self.shoeAlert(title: "Error", message: error.localizedDescription)
            }
            self.navigateBasedOnUserType()

        }
    }
    func navigateBasedOnUserType() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(userId).getDocument {
            snapshot, error in
            if let data = snapshot?.data(),
               let userType = data["userType"] as? String {
                if userType == "admin" {
                    self.performSegue(withIdentifier: "goToAdminDashboard", sender: self)
                    
                }
                if userType == "student" {
                    self.performSegue(withIdentifier: "goToStudentDashboard", sender: self)
                }
                if userType == "maintenanceTeam" {
                    self.performSegue(withIdentifier: "goToMaintenanceTeam", sender: self)
                }
            }
        }
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
