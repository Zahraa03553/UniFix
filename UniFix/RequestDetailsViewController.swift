//
//  RequestDetailsViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 24/12/2025.
//

import UIKit
import FirebaseFirestore
class RequestDetailsViewController: UIViewController {
    var Request: Request?
    
    @IBOutlet weak var lblReqID: UILabel!
    
    @IBOutlet weak var lblReqDate: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblReqID.text = Request?.id
        let dateF = Request?.date as? Timestamp
        let df = dateF?.dateValue()
        lblReqDate.text = DateFormatter.localizedString(from: df!, dateStyle: .medium, timeStyle: .short)
        lblNumber.text = Request?.contact
        lblCategory.text = Request?.category
        lblSubject.text = Request?.subject
        lblName.text = Request?.FullName
        lblDetails.text = Request?.description
        lblLevel.text = Request?.urgency
        lblLocation.text = Request?.location
        
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
