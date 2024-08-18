//
//  CreateAccountViewController.swift
//  Team_19_App
//
//  Created by Sambhav Singh on 02/06/24.
//

import UIKit
import Firebase

var userName:String? = nil
var capturedImage: UIImage?

class CreateAccountViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
               view.endEditing(true)
           }
    
    
    @IBAction func uploadPhotoButtonTapped(_ sender: UIButton) {
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        
        let alertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction=UIAlertAction(title: "Camera", style: .default, handler: {action in imagePicker.sourceType = .camera; self.present(imagePicker, animated: true, completion: nil)})
            
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction=UIAlertAction(title: "Photo Library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)})
            
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView=sender
        
        present(alertController, animated: true
                , completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           guard let selectedImage = info[.originalImage] as? UIImage else{return}
        
        capturedImage = selectedImage
           
           userImage.image=selectedImage
           dismiss(animated: true, completion: nil)
       }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        userName = userNameTextField.text
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error{
                print("error")
            }
            else {
                self.performSegue(withIdentifier: "MoveToHome", sender: self)
            }
        }
    }

}
