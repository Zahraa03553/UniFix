//
//  RequestFormViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 12/12/2025.
//

import UIKit

class RequestFormViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var urgencyLevelTxt: UITextField!
    @IBOutlet weak var detailsTxt: UITextField!
    @IBOutlet weak var subjectTxt: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var contactNumberTxt: UITextField!
    @IBOutlet weak var issueCategoryTxt: UITextField!
    @IBOutlet weak var locationTxt: UITextField!
  //  let errorMessage =  UILabel()
    var myPickerView: UIPickerView!
    var listoFCategories =  ["Electrical","Plumbing","IT","HVAC","Safety","Furniture","GroundKeeping","ACCessibility"]
  //  var levelPickerView: UIPickerView!
    var listLevels = ["High","Medium","Low"]
   override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subjectTxt.layer.borderWidth = 1
        subjectTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        subjectTxt.layer.cornerRadius = 8
        issueCategoryTxt.layer.borderWidth = 1
       issueCategoryTxt.layer.cornerRadius = 8
        issueCategoryTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
       setupPickerView(_textField: issueCategoryTxt)
        locationTxt.layer.borderWidth = 1
        locationTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
       locationTxt.layer.cornerRadius = 8
       urgencyLevelTxt.layer.borderWidth = 1
       urgencyLevelTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
       urgencyLevelTxt.layer.cornerRadius = 8
       urgencyLevelTxt.layer.cornerRadius = 8
       setupPickerView(_textField: urgencyLevelTxt)
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
    func setupPickerView(_textField: UITextField) {
        myPickerView = UIPickerView()
        myPickerView.delegate = self
        myPickerView.dataSource = self
        _textField.inputView = myPickerView
       let toolbar = UIToolbar()
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
       toolbar.setItems([doneButton], animated: false)
        _textField.inputAccessoryView = toolbar
       
   }
@objc private func donePressed() {
   view.endEditing(true)
   }
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
   }
   func pickerView(_ _pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
   return listoFCategories.count
}
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return listoFCategories[row]
   }
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       issueCategoryTxt.text = listoFCategories[row]
   }
//
    func upickerView(_ _pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return listLevels.count
 }
    func upickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return listLevels[row]
       }
    func upickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        urgencyLevelTxt.text = listLevels[row]
    }
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: " Please fill all the required fields", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true)
     }
    func showAlert(massage: String) {
        let alert = UIAlertController(title: nil,message: massage, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true)
     }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
            
            
        }else {
            showAlert(massage: "Camera not available")
        }
    }
    
    @IBAction func choserButtonTapped(_ sender: UIButton) {
    }
    @IBAction func goToCameta(_ sender: UIButton) {
        openCamera()
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        //
        guard let subject = subjectTxt.text, !subject.isEmpty else {
            showAlert()
            return
        }
        guard let issuelocation = locationTxt.text, !subject.isEmpty else {
            showAlert()
            return
        }
        guard let issuuedescription = detailsTxt.text, !subject.isEmpty else {
            showAlert()
            return
        }
        guard let cotactNo = contactNumberTxt.text, !subject.isEmpty else {
            showAlert()
            return
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

