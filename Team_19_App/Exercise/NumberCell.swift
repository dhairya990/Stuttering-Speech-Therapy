//
//  NumberCell.swift
//  ExerciseNew5
//
//  Created by Dhairya bhardwaj on 02/06/24.
//

import UIKit

class NumberCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        numberLabel.font = UIFont.systemFont(ofSize: 30)
        self.contentView.layer.cornerRadius = 14
        self.contentView.layer.masksToBounds = true
    }
    func configure(with number: Int, isSelected: Bool) {
        numberLabel.text = "\(number)"
        if isSelected {
            self.contentView.backgroundColor = UIColor.systemBlue
            numberLabel.textColor = .white
        } else {
            self.contentView.backgroundColor = UIColor.systemFill
            numberLabel.textColor = .darkGray
        }
    }
}
