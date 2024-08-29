//
//  ViewController.swift
//  DemoCore
//
//  Created by Saumil on 23/07/24.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    
    // MARK: - Outlets
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    // MARK: - Class Properties
    
    var imageName = UUID().uuidString + ".png" // Unique file name
    var user: Student?
    
    // MARK: - Life Cycle Functions
    
    
    // MARK: - Memory Management Functions
    
    
    // MARK: - Class Functions
    
    func validation() -> Bool {
        if self.txtName.text!.isEmpty {
            presentAlert(withTitle: "Alert", message: "Please fill the name")
            return false
        } else if self.txtAddress.text!.isEmpty {
            presentAlert(withTitle: "Alert", message: "Please fill the address")
            return false
        } else if self.txtCity.text!.isEmpty {
            presentAlert(withTitle: "Alert", message: "Please fill the city")
            return false
        } else if self.txtMobileNumber.text!.isEmpty {
            presentAlert(withTitle: "Alert", message: "Please fill the mobile number")
            return false
        } else if self.img.image == nil {
            presentAlert(withTitle: "Alert", message: "Please Add image")
            return false
        }
        return true
    }
    
    func userConfiguartion() {
        if let user {
            txtName.text = user.name
            txtAddress.text = user.address
            txtCity.text = user.city
            txtMobileNumber.text = user.mobile
            if let image = CoreDataManager.shared.loadImageFromDocumentsDirectory(fileName: user.imgName ?? "") {
                img.image = image
            } else {
                img.image = nil  // Handle the case where the image isn't found
            }
        } else {
            txtName.text = ""
            txtAddress.text = ""
            txtCity.text = ""
            txtMobileNumber.text = ""
        }
    }
    
    
    
    
    
    // MARK: - Action Function
    
    @IBAction func btnSaveClick(_ sender: Any) {
        
        if validation() {
            let newUser = UserModal(name: self.txtName.text, address: self.txtAddress.text, city: self.txtCity.text, mobile: self.txtMobileNumber.text, image: imageName)
            if let user {
                // update
                CoreDataManager.shared.updateUserData(user: newUser, userEntity: user)
            } else {
                // add
                CoreDataManager.shared.saveData(user: newUser)
            }
            
            
        }
        
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnImgeTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .photoLibrary
                present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - Web Service Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userConfiguartion()
        // Do any additional setup after loading the view.
    }


}

extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        print("You've pressed OK Button")
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                img.contentMode = .scaleAspectFit
                img.image = pickedImage
                CoreDataManager.shared.saveImageToDocumentsDirectory(image: pickedImage, fileName: imageName)
            }
            dismiss(animated: true, completion: nil)
        }
        
        // Delegate method: When the user cancels the picker
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
}
