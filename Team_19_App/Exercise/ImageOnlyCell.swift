//
//  ImageOnlyCell.swift
//  ExerciseNew5
//
//  Created by Dhairya bhardwaj on 02/06/24.
//

import UIKit

class ImageOnlyCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var greetingDeifne: UILabel!
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    let currentHour = Calendar.current.component(.hour, from: Date())
    
    func configure(with imageName: String, greeting: String) {
            if let image = UIImage(named: imageName)
        {
                imageView.image = image
            } else {
                print("Error: Image named \(imageName) not found")
            }
        if (6..<12).contains(currentHour) {
            greetingDeifne.text = "Morning"
        } else if (12..<18).contains(currentHour) {
            greetingDeifne.text = "Afternoon"
        } else {
            greetingDeifne.text = "Evening"
        }
        
        greetingLabel.text = greeting
            // Add rounded corners
            imageView.layer.cornerRadius = 35 // Adjust the corner radius as needed
            imageView.clipsToBounds = true
        }
}
