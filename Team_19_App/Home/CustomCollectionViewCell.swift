//
//  CustomCollectionViewCell.swift
//  Team_19_App
//
//  Created by Dhairya bhardwaj on 24/05/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
        setupCell()
       }
    
    private func setupCell() {
            
            self.contentView.layer.cornerRadius = 20
            self.contentView.layer.masksToBounds = true
            self.layer.cornerRadius = 50
            self.layer.masksToBounds = false
           
        }
    
}
