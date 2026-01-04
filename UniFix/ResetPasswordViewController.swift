//
//  ResetPasswordViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 03/01/2026.
//

import UIKit

import FirebaseAuth
class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        txtEmail.layer.cornerRadius = 8
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        resetButton.animateGradient(colors: [UIColor.primaryDarkGrey,UIColor.primaryGrey])
    }


    @IBAction func ResetButtonTapped(_ sender: UIButton) {
        //validate the email not empty
        guard let email = txtEmail.text, !email.isEmpty else {
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error sending password reset email: \(error.localizedDescription)")
                return
            } else {
                let alert = UIAlertController(title: "Email Sent", message: "Password reset email has been sent to your email address.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
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
