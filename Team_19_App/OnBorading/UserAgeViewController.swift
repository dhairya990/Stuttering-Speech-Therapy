//
//  UserAgeViewController.swift
//  Team_19_App
//
//  Created by Batch-2 on 07/06/24.
//

import UIKit

var userAge:Int?

class UserAgeViewController: UIViewController {
    
    @IBOutlet var userAgeDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        userAgeDatePicker.datePickerMode = .date
        userAgeDatePicker.maximumDate = Date()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateAge(_ sender: UIButton) {
        let dob = userAgeDatePicker.date
        let age = calculateAge(from: dob)
        userAge = age
        print("\(age)")
    }
    func calculateAge(from date: Date)->Int{
        let calender = Calendar.current
        let now = Date()
        let ageComponents = calender.dateComponents([.year], from: date, to: now)
        return ageComponents.year!
    }

}
