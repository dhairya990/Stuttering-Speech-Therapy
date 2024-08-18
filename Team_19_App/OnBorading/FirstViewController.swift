//
//  FirstViewController.swift
//  Team_19_App
//
//  Created by Sambhav Singh on 27/05/24.
//

import UIKit

var dataSet = ["Image 1","Image 2"]

class FirstViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var pageView: UIPageControl!
    
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

                // Do any additional setup after loading the view.
        pageView.numberOfPages = dataSet.count
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
        updateImageView()
        
    }
    func updateImageView(){
        imageView.image = UIImage(named: dataSet[currentCellIndex])
        pageView.currentPage = currentCellIndex
    }
    
    @objc func scrollToNextCell() {
        currentCellIndex=(currentCellIndex+1) % dataSet.count
        updateImageView()
      }
}
