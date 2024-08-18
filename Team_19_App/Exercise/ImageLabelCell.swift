//
//  ImageLabelCell.swift
//  ExerciseNew5
//
//  Created by Dhairya bhardwaj on 02/06/24.
//

import UIKit

class ImageLabelCell: UICollectionViewCell {
    weak var delegate: ImageLabelCellDelegate?
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with imageName: String, label: String, duration: String) {
           imageView.image = UIImage(named: imageName)
           titleLabel.text = label
           durationLabel.text = duration
        view.layer.cornerRadius = 20
       }
    @objc func titleLabelTapped() {
            delegate?.didTapIntroductionLabel()
        }
}
protocol ImageLabelCellDelegate: AnyObject {
    func didTapIntroductionLabel()
}
