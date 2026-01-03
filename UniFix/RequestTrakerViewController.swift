//
//  RequestTrakerViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 17/12/2025.
//

import UIKit
import FirebaseAuth
import  FirebaseFirestore
class RequestTrakerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    let userid = Auth.auth().currentUser!.uid
    @IBOutlet weak var RequestTable: UITableView!
    var Requests: [Request] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        RequestTable.delegate = self
        RequestTable.dataSource = self
        fatchRequest()
    }
    
    func fatchRequest() {
        
        db.collection("MaintenanceRequest").order(by: "date", descending: true).whereField("SendBy", isEqualTo: userid).addSnapshotListener { querysnapshot, error
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
                    Accept: "Accept"
                )
                
                fatchData.append(Request)
            }
            self.Requests = fatchData
            self.RequestTable.reloadData()
        }
    }
    @IBOutlet weak var RequestCell: UITableViewCell!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! RequestTrakerTabelCellTableViewCell
        let request = Requests[indexPath.row]
        cell.textLabel?.text = request.subject
        cell.statusLabel?.text = request.status
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destination = segue.destination as? RequestDetailsViewController{
                if let indexPath = RequestTable.indexPathForSelectedRow {
                    let selectedRequest = Requests[indexPath.row]
                    destination.Request = selectedRequest
                }
            }
        }
    }
    /*
    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {1ZPHD0U0YWKYY/FirebaseAuthInterop-PLELVRC4TWI7.pcm' does not existwarning: (arm64) /Users/zahraahumaidan/Library/Developer/Xcode/DerivedData/UniFix-bowekbspfzewoahe

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
