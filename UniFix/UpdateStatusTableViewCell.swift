//
//  UpdateStatusTableViewCell.swift
//  UniFix
//
//  Created by zahraa humaidan on 03/01/2026.
//

import UIKit
import FirebaseFirestore
// Protocol for button action sheat in table view
protocol UpdateStatusTableViewCellDelegate: AnyObject {
func updateStatusTapped(in cell: UpdateStatusTableViewCell,  sender: UIButton)
}
class UpdateStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var UpdateButton: UIButton!
    var reqid:String!
    weak var delegate: UpdateStatusTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //Button Action
    
    @IBAction func UpdateButtonTapped(_ sender: UIButton) {
        delegate?.updateStatusTapped(in: self, sender: sender)
    }
    // Update to In Progress
    func updateStatusInProgress(){
        let db = Firestore.firestore()
        db.collection("MaintenanceRequest").document(reqid).updateData(["status":"In Progress"])  { error in
            if let error = error {
                print("Error updating document: \(error)")
            }else {
                print("In Progress")
            }
        }
    }
// Update to completed
    func updateStatusCompleted(){
        let db = Firestore.firestore()
        db.collection("MaintenanceRequest").document(reqid).updateData(["status":"Completed"])  { error in
            if let error = error {
                print("Error updating document: \(error)")
            }else {
                print("Completed")
            }
        }
    }
}

