//
//  RequestFormViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 12/12/2025.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class RequestFormViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var urgencyLevelTxt: UITextField!
    
    @IBOutlet weak var detailsTxt: UITextView!
    
    @IBOutlet weak var subjectTxt: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var contactNumberTxt: UITextField!
    @IBOutlet weak var issueCategoryTxt: UITextField!
    @IBOutlet weak var locationTxt: UITextField!
    
    //  let errorMessage =  UILabel()
    var myPickerView: UIPickerView!
    var listoFCategories =  ["Select Issue Category","Electrical","Plumbing","IT","HVAC","Safety","Furniture","GroundKeeping","ACCessibility"]
    // urgency level
    var levelPickerView: UIPickerView!
    var listLevels = ["Select Urgency Level","High","Medium","Low"]
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subjectTxt.layer.borderWidth = 1
        subjectTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        subjectTxt.layer.cornerRadius = 8
        issueCategoryTxt.layer.borderWidth = 1
        issueCategoryTxt.layer.cornerRadius = 8
        issueCategoryTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        setupPickerView()
        locationTxt.layer.borderWidth = 1
        locationTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        locationTxt.layer.cornerRadius = 8
        urgencyLevelTxt.layer.borderWidth = 1
        urgencyLevelTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        urgencyLevelTxt.layer.cornerRadius = 8
        setupUPickerView()
        detailsTxt.layer.borderWidth = 1
        detailsTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        detailsTxt.layer.cornerRadius = 8
        contactNumberTxt.layer.borderWidth = 1
        contactNumberTxt.layer.cornerRadius = 8
        contactNumberTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        submit.animateGradient(colors: [UIColor.primaryDarkGrey,UIColor.primaryGrey])
        
    }
    func setupPickerView() {
        myPickerView = UIPickerView()
        myPickerView.delegate = self
        myPickerView.dataSource = self
        issueCategoryTxt.inputView = myPickerView
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        issueCategoryTxt.inputAccessoryView = toolbar
        
    }
    func setupUPickerView() {
        levelPickerView = UIPickerView()
        levelPickerView.delegate = self
        levelPickerView.dataSource = self
        urgencyLevelTxt.inputView = levelPickerView
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        urgencyLevelTxt.inputAccessoryView = toolbar
        
    }
    @objc private func donePressed() {
        view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ _pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if _pickerView == myPickerView {
            return listoFCategories.count
        }
        else {
            return listLevels.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == myPickerView {
            return listoFCategories[row]
        } else {
            return listLevels[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == myPickerView {
            issueCategoryTxt.text = listoFCategories[row]
        }else{
            urgencyLevelTxt.text = listLevels[row]
        }
    }
    //
    
    
    // show alert
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: " Please fill all the required fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    func showAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title,message: massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    
    @IBAction func submitButton(_ sender: UIButton) {
        //
        guard let subject = subjectTxt.text, !subject.isEmpty else {
            showAlert()
            return
        }
        let selectedRow = myPickerView.selectedRow(inComponent: 0)
        let issueType: String
        
        if selectedRow == 0 {
            showAlert()
            return
        }else {
            issueType = listoFCategories[selectedRow]
        }
        guard let issuelocation = locationTxt.text, !issuelocation.isEmpty else {
            showAlert()
            return
        }
        let lSelectedRow = levelPickerView.selectedRow(inComponent: 0)
        let level: String
        if lSelectedRow == 0 {
            showAlert()
            return
        }else {
            level = listLevels[lSelectedRow]
        }
        
        guard let issuuedescription = detailsTxt.text, !issuuedescription.isEmpty else {
            showAlert()
            return
        }
        guard let cotactNo = contactNumberTxt.text, !cotactNo.isEmpty else {
            showAlert()
            return
            
        }
        if !subject.isEmpty && !issueType.isEmpty && !issuelocation.isEmpty && !level.isEmpty && !issuuedescription.isEmpty && !cotactNo.isEmpty {
            showAlert(title:"Successful Submission",  massage: "You have submit the request successfully!")
        }else{
            return
        }
            
        guard let username = Auth.auth().currentUser else { return }

        fatchUserName(userID: username.uid) { fullname in
            let userRequest = Request(id:UUID().uuidString,subject: subject, category: issueType, location: issuelocation , urgency: level , description: issuuedescription, contact: cotactNo ,status: "New", date: nil, FullName: fullname!, Accept: "Accept")
            
            self.saveToFirestore(userRequest)
       
            
        }
    }
    func fatchUserName(userID: String, completion: @escaping (String?) -> Void)  {
        db.collection( "users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists,
                let dataDescription = document.data(),
               let userName = dataDescription["userFullName"] as? String {
                completion(userName)
            }else {
               print("User not found")
                completion(" User not found")
            }
        }
    }
    func saveToFirestore(_ Request: Request)  {
        
        db.collection("MaintenanceRequest").document(Request.id).setData(["subject": Request.subject, "category": Request.category, "location": Request.location, "urgency": Request.urgency, "description": Request.description, "contact": Request.contact,"status": "New", "date": FieldValue.serverTimestamp(), "userFullName": Request.FullName, "Accept": "Accept","SendBy": Auth.auth().currentUser!.uid])
        { error in
            if let error = error {
                print("Document added with ID:\(error.localizedDescription)")
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

