//
//  PopUpViewController.swift
//  CountingPushUp
//
//  Created by KSI on 2020/06/06.
//  Copyright © 2020 KSI. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet var Showing: UILabel!
    var receivedText: String = "0"
    
    override func viewDidLoad() {
        Showing.text = receivedText
    }
    
    @IBAction func comeBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
