//
//  loginViewController.swift
//  Team_19_App
//
//  Created by Sambhav Singh on 30/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class loginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.cornerRadius=20
        loginView.layer.shadowOpacity = 0.15
        loginView.layer.shadowOffset = .init(width: 0, height: 10)
        loginView.layer.shadowColor = UIColor.black.cgColor
        
        loginView.layer.masksToBounds = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

       // Auth.auth().createUser(withEmail: "", password: "")

        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
               view.endEditing(true)
           }
    
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error{
                print("error")
            }
            else {
              self.performSegue(withIdentifier: "MoveToHome", sender: self)
            }
        }
        
    }

}
