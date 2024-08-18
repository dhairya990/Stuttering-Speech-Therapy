//
//  GameFileViewController.swift
//  Team_19_App
//
//  Created by Sambhav Singh on 31/05/24.
//

import UIKit

class GameFileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func GameStartButton(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Space", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "GameRun")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
}
