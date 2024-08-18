//
//  UserProfileViewController.swift
//  Team_19_App
//
//  Created by indianrenters on 07/06/24.
//

import UIKit

class UserProfileViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
            
            switch indexPath.row {
            case 0:
                cell.iconImageView.image = UIImage(systemName: "person")
                //cell.detailLabel.text = "\(userName!)"
            case 1:
                cell.iconImageView.image = UIImage(systemName: "figure")
                           if let age = userAge {
                               cell.detailLabel.text = "\(age)"
                               cell.detailLabel.text = "\(userAge)"
                           } else {
                               cell.detailLabel.text = "Age not Set"
                           }
            case 2:
                cell.iconImageView.image = UIImage(systemName: "phone")
                cell.detailLabel.text = "818 123 4567"
            
            case 3:
                cell.iconImageView.image = UIImage(systemName: "envelope")
                cell.detailLabel.text = "info@aplusdesign.co"
            case 4:
                cell.iconImageView.image = UIImage(systemName: "lock")
                cell.detailLabel.text = "Password"
            default:
                break
            }
            
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60 //  height
        }
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!

    
    var userAge: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = capturedImage
        tableView.dataSource = self
        tableView.delegate = self
               
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func editUserPhoto(_ sender: UIButton) {
        let imagePicker=UIImagePickerController()
        //imagePicker.delegate=self
        
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
           
           imageView.image=selectedImage
           dismiss(animated: true, completion: nil)
       }
}

