//
//  RequestFormViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 12/12/2025.
//

import UIKit

class RequestFormViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var detailsTxt: UITextField!
    @IBOutlet weak var subjectTxt: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var contactNumberTxt: UITextField!
    @IBOutlet weak var issueCategoryTxt: UITextField!
    @IBOutlet weak var urgencyButton: UIButton!
    let arrowImage = UIImageView(image: UIImage(systemName: "chevron.down"))
    let dropDownTableView = UITableView()
    let urgencyLevels = ["High", "Medium", "Low"]
    var isDropDownOpen = false
    @IBOutlet weak var locationTxt: UITextField!
    let errorMessage =  UILabel()
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subjectTxt.layer.borderWidth = 1
        subjectTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        subjectTxt.layer.cornerRadius = 8
        issueCategoryTxt.layer.borderWidth = 1
        issueCategoryTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
        locationTxt.layer.borderWidth = 1
        locationTxt.layer.borderColor = UIColor.primaryDarkGrey.cgColor
       locationTxt.layer.cornerRadius = 8
       urgencyButton.addTarget(self, action: #selector(toggleDropDown), for: .touchUpInside)
       dropDownTableView.isHidden = true
       dropDownTableView.delegate = self
       dropDownTableView.dataSource = self
       dropDownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
    @objc func toggleDropDown() {
        isDropDownOpen.toggle()
        dropDownTableView.isHidden = !isDropDownOpen
        UIView.animate(withDuration: 0.3) {
            self.arrowImage.transform = self.isDropDownOpen ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        urgencyLevels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = urgencyLevels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        urgencyButton.setTitle(urgencyLevels[indexPath.row], for: .normal)
        toggleDropDown()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDropDownOpen {
            toggleDropDown()
        }
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

