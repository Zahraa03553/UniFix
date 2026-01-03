//
//  TaskListViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 26/12/2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UpdateStatusTableViewCellDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var Requests: [Request] = []
    let id = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        fatchRequest()
    }
    func fatchRequest() {
        let db = Firestore.firestore()
        db.collection("MaintenanceRequest").order(by: "date", descending: true).whereField("AcceptedBy", isEqualTo: id!).addSnapshotListener  { querysnapshot, error
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
            self.tableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Requests.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! UpdateStatusTableViewCell
        cell.delegate = self
        let task = Requests[indexPath.row]
        cell.reqid = task.id
        cell.textLabel?.text = task.subject
        switch task.status {
        case "In Progress":
            cell.UpdateButton.setTitle("In Progress", for:  .normal)
            case "Completed":
            cell.UpdateButton.setTitle("Completed", for: .normal)
            
        default:
            cell.UpdateButton.setTitle("Update Status", for: .normal)
        }
        return cell
    }
    // use protocol func
    func updateStatusTapped(_ cell: UpdateStatusTableViewCell){
        let actionSheet = UIAlertController(title: "Update Status", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "In Progress", style: .default, handler: { (_) in
            cell.updateStatusInProgress()
        }))
        actionSheet.addAction(UIAlertAction(title: "Completed", style: .default, handler: { (_) in
            cell.updateStatusCompleted()

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTask" {
            if let destination = segue.destination as? RequestDetailsViewController{
                if let indexPath = tableView.indexPathForSelectedRow {
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
