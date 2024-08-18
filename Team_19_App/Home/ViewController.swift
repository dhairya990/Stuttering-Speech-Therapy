//
//  ViewController.swift
//  tryingCharts
//
//  Created by Sambhav Singh on 28/05/24.
//

import UIKit
import SwiftUI
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
        // Do any additional setup after loading the view.
    }
    func setUpview(){
        let controller = UIHostingController(rootView: newchart())
        guard let dataview = controller.view  else {
            return
        }
        
        view.addSubview(dataview)
        
        dataview.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
    }

}

