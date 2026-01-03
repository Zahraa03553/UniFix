//
//  MyProfileViewCellViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 03/01/2026.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class MyProfileViewCellViewController: UIViewController {

    @IBOutlet weak var txtFullName: UILabel!
    
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    var user: [UserAccount] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fatchUserInfo()
    }
    func fatchUserInfo() {
        let db = Firestore.firestore()
        
        db.collection("users").document(Auth.auth().currentUser!.uid).getDocument(source: .default) { (document, error)
            in
              if let error = error {
             print("Error:\(error) ")
              return
             }
            
            if let document = document,  document.exists {
                let data = document.data()
                let userinfo = UserAccount(
                    id: document.documentID,
                    fullName: data!["userFullName"] as!  String,
                    
                    email: data!["email"] as! String,
                    userType: data!["userType"] as! String?,
                )
                self.updateUI(with: userinfo)
                
            }
        }
        
    }
    func updateUI(with user: UserAccount) {
        txtEmail.text = user.email
        txtFullName.text = user.fullName
        txtType.text = user.userType
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
