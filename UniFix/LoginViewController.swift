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
        // Email text field design
        emailTxt.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        emailTxt.layer.borderWidth = 1
        emailTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        emailTxt.layer.cornerRadius = 8
      // Password text field design
        passwordTxt.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        passwordTxt.layer.borderWidth = 1
        passwordTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        passwordTxt.layer.cornerRadius = 8
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.animateGradient(colors: [UIColor.primaryDarkGrey,UIColor.primaryGrey])
    
    }
    @objc func validateFields() {
        loginButton.isEnabled = !emailTxt.text!.isEmpty && !passwordTxt.text!.isEmpty
    }
   func shoeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    
     let email = emailTxt.text!

        let password = passwordTxt.text!
        

        Auth.auth().signIn(withEmail: email, password: password) {
         [weak self]   authResult, error in
            if let error = error {
                self?.shoeAlert(title: "Error", message: error.localizedDescription)
                return
            }
            if let userID = authResult?.user.uid {
                UserDefaults.standard.set(userID, forKey: UserDefaultsKeys.userlD)
            }
            self?.navigateBasedOnUserType()

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
                if userType == "student" || userType == "staff" {
                    self.performSegue(withIdentifier: "goToStudentDashboard", sender: self)
                }
                if userType == "MaintenanceTeam" {
                    self.performSegue(withIdentifier: "goToMaintenanceDashboard", sender: self) 
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
