//
//  MaintenanceDashboardViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 24/12/2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MaintenanceDashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AcceptDelegate {
   
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var NewRequestTableView: UITableView!
    var Requests: [Request] = []

    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NewRequestTableView.dataSource = self
        NewRequestTableView.delegate = self
        if let user = Auth.auth().currentUser {
            print("Signed in user: \(user.uid)")
            fatchRequest()
        }
    }
    func fatchRequest() {
        let db = Firestore.firestore()
        db.collection("MaintenanceRequest").order(by: "date", descending: true).addSnapshotListener  { querysnapshot, error
            in
            if let error = error {
                print("Error:\(error) ")
                return
            }
            
            var fatchData: [Request] = []
            for document in querysnapshot!.documents {
                let data = document.data()
                let Request = Request(
                    id: document.documentID,
                    subject: data["subject"] as! String,
                    category: data["category"] as! String,
                    location: data["location"] as! String,
                    urgency: data["urgency"] as! String,
                    description: data["description"] as! String,
                    contact: data["contact"] as!  String,
                    status: data["status"] as!  String,
                    date:  data["date"] as? Timestamp,
                    FullName: data["userFullName"] as!  String,
                    Accept: data["Accept"] as!  String
                )
                
                fatchData.append(Request)
            }
            self.Requests = fatchData
            self.NewRequestTableView.reloadData()
        }
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return Requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewRequestCell", for: indexPath) as! AcceptCellTableViewCell
        cell.delegate = self
      let requests = Requests[indexPath.row]
        cell.textLabel?.text = requests.subject
        cell.reqid = requests.id
        cell.AcceptLabel.setTitle(requests.Accept, for: .normal)
        switch requests.Accept {
            
        case  "Accepted":
            cell.AcceptLabel.setTitleColor(UIColor.white, for: .disabled)
            cell.AcceptLabel.backgroundColor = UIColor.black
            cell.AcceptLabel.isEnabled = false
        default:
            cell.AcceptLabel.setTitleColor(UIColor.white, for: .normal)
            cell.AcceptLabel.backgroundColor = UIColor.primaryDarkGrey


        }
        return cell
    }
    func didTappedAccept(_ cell: AcceptCellTableViewCell) {
        let alert = UIAlertController(title: "Are you sure you want to accept this request?", message: "Please tap accept to proceed", preferredStyle: .alert)
       
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { _ in
            cell.updatabutton()
            cell.addTask(reqid: cell.reqid, teamid: cell.userid!)
        }))
       
        
        self.present(alert, animated: true)
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
            "loginNB") as? UINavigationController
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
    
    
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        showAlertConform()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsM" {
            if let destination = segue.destination as? RequestDetailsViewController{
                if let indexPath = NewRequestTableView.indexPathForSelectedRow {
                    let selectedRequest = Requests[indexPath.row]
                    destination.Request = selectedRequest
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
