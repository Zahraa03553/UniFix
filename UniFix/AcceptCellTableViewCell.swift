//
//  AcceptCellTableViewCell.swift
//  UniFix
//
//  Created by zahraa humaidan on 01/01/2026.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore
protocol AcceptDelegate: AnyObject {
  func didTappedAccept(_ cell: AcceptCellTableViewCell)
}
class AcceptCellTableViewCell: UITableViewCell {
    var reqid: String!
    let userid = Auth.auth().currentUser?.uid
    @IBOutlet weak var AcceptLabel: UIButton!
    weak var delegate: AcceptDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func AcceptTapped(_ sender: UIButton) {
        delegate?.didTappedAccept( self)
       
    }
    func updatabutton(){
        let db = Firestore.firestore()
        db.collection("MaintenanceRequest").document(reqid).updateData(["Accept":"Accepted", "status":"Pending","AcceptedBy": userid!])  { error in
            if let error = error {
                print("Error updating document: \(error)")
            }else {
                print("Accepted")
                //   self.AcceptButton.setTitle( "Accepted", for: .normal)
                //self.acceptButton.setTitle("Accepted", for: .normal)
            }
            
        }
        
    }
    //
    func addTask(reqid: String, teamid: String){
        let db = Firestore.firestore()
        let taskDate: [String: Any] = ["Requestid": reqid]
        db.collection("users").document(teamid).collection("taskList").addDocument(data: taskDate) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
}

