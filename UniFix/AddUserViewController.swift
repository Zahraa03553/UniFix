//
//  AddUserViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 02/01/2026.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
class AddUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    

    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtUserType: UITextField!
    @IBOutlet weak var userTypeView: UIStackView!
    @IBOutlet weak var txtPassword: UITextField!
    let type = ["student", "staff", "MaintenanceTeam"]
    
    @IBOutlet weak var typeTable: UITableView!
    @IBOutlet weak var AddNewButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        typeTable.dataSource = self
        typeTable.delegate = self
        typeTable.isHidden = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        txtFullName.layer.cornerRadius = 8
        txtFullName.layer.borderWidth = 1
        txtFullName.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        // Email
        txtEmail.layer.cornerRadius = 8
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        // Password
        txtPassword.layer.cornerRadius = 8
        txtPassword.layer.borderWidth = 1
        txtPassword.layer.borderColor = UIColor.primaryDarkGrey.cgColor
    // user Type
      userTypeView.layer.cornerRadius = 8
        userTypeView.layer.borderWidth = 1
        userTypeView.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        // Add Button
        AddNewButton.animateGradient(colors: [UIColor.primaryDarkGrey,UIColor.primaryGrey])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTypeCell", for: indexPath)
        cell.textLabel?.text = type[indexPath.row]
        return cell

        
    }

    @IBAction func showType(_ sender: UIButton) {
      typeTable.isHidden.toggle()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = type[indexPath.row]
        txtUserType.text = selected
        typeTable.isHidden = true
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func AddNewTapped(_ sender: UIButton) {
    // Add
        guard let username = txtFullName.text, !username.isEmpty else {
            showAlert(title: "Missing Name", message: "Please enter user full name.")
            return
        }
       guard let email = txtEmail.text, !email.isEmpty else {
            showAlert(title: "Missing Email", message: "Please anter email address.")
            return
        }
        guard let password = txtPassword.text, !password.isEmpty else {
            showAlert (title: "Missing Password", message: "Pleaseenter password.")
            return
        }
        guard let userRole = txtUserType.text, !userRole.isEmpty else {
        
            showAlert (title: "Missing UserType", message:"Please select user type.")
           print("Error")
           return
          }
        
        // Validate password length
        guard password.count >= 6 else {
            showAlert(title: "Weak Password", message: "Password must be at least 6 characters long.")
            return
        }
        
        // Create user account with Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) {
             (authResult, error) in
            if let  error = error {
                // Registration failed - show error message
                self.showAlert(title: "Adding Failed", message:error.localizedDescription)
                return
            }
            guard let user = authResult?.user else {
                return
           }
             
            let Usera = UserAccount(id: user.uid , fullName: username , email: email, userType: userRole )
           self.saveToFirestore(Usera)
            self.showAlert(title: "Successful", message: "User added successfully.")
        }
        // Added successful
       
   
    
    }

    func saveToFirestore(_ UserAccount: UserAccount)  {
        let db = Firestore.firestore()
        db.collection("users").document(UserAccount.id!).setData(["userFullName":UserAccount.fullName, "email": UserAccount.email, "userType": UserAccount.userType!]) { error in
            if let error = error {
                print("Document Error: \(error.localizedDescription)")
            }else {
                print("Document added successfully")
            }
            
        }
        
        Auth.auth().signIn(withEmail: "unifix.admi@gmail.com", password: "Zah03553"){ result, errot in
            if let error = errot {
                print("Error: \(error.localizedDescription)")
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
