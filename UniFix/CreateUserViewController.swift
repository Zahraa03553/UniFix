//
//  CreateUserViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 24/12/2025.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
class CreateUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var rxtUserType: UITextField!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var drobDownButton: UIButton!
    @IBOutlet weak var userTypeList: UITableView!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        userTypeList.delegate = self
        userTypeList.dataSource = self
        userTypeList.isHidden = true
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        AddButton.animateGradient(colors: [UIColor.primaryDarkGrey,UIColor.primaryGrey])
        txtFullName.layer.cornerRadius = 8
        txtFullName.layer.borderWidth = 1
        txtFullName.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        // Email text Field layer
        txtEmail.layer.cornerRadius = 8
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        // Password text Field layer
        txtPassword.layer.cornerRadius = 8
        txtPassword.layer.borderWidth = 1
        txtPassword.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        // DrobDawn Button  Field layer
        rxtUserType.layer.cornerRadius = 8
        rxtUserType.layer.borderWidth = 1
        rxtUserType.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        userTypeList.layer.borderWidth = 1
        userTypeList.layer.borderColor = UIColor.primaryDarkGrey.cgColor
    }
    
    @IBAction func showDrobDawn(_ sender: UIButton) {
        userTypeList.isHidden.toggle()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userType", for: indexPath)
        cell.textLabel?.text = indexPath.row == 0 ? "Student/Staff" : "MaintananceTeam"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = indexPath.row == 0 ? "Student/Staff" : "MaintananceTeam"
        rxtUserType.text = selected
        userTypeList.isHidden = true
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    @IBAction func addNewUser(_ sender: UIButton) {
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
        guard let userRole = rxtUserType.text, !userRole.isEmpty else {
        
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
             
            let Usera = UserAccount(id: user.uid , fullName: username , email: email, userType: userRole)
            self.saveToFirestore(Usera)
            self.showAlert(title: "Successful", message: "User added successfully.")
    }
        // Added successful
       
   
    
    }

    func saveToFirestore(_ UserAccount: UserAccount)  {
      
        db.collection("users").document(UserAccount.id).setData(["FullName":UserAccount.fullName, "Email": UserAccount.email, "userType": UserAccount.userType!]) { error in
            if let error = error {
                print("Document Error: \(error.localizedDescription)")
            }else {
                print("Document added successfully")
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
