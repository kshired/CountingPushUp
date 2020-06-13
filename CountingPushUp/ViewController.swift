//
//  ViewController.swift
//  CountingPushUp
//
//  Created by KSI on 2020/06/06.
//  Copyright © 2020 KSI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var txtTime: UILabel!
    
    var countNum: Int = 0
    var mTimer : Timer?
    var number : Int = 0
    var firstCheck : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func countingReset(_ sender:Any){
        self.proximitySensorActivation()
        countLabel.text = "0 times"
        if let timer = mTimer {
            if !timer.isValid {
                mTimer = Timer.scheduledTimer(
                            timeInterval: 1,
                            target: self,
                            selector: #selector(timerCallback),
                            userInfo: nil,
                            repeats: true
                        )
            }
        }else{
            mTimer = Timer.scheduledTimer(
                        timeInterval: 1,
                        target: self,
                        selector: #selector(timerCallback),
                        userInfo: nil,
                        repeats: true
                    )
        }
    }
    
    @IBAction func onTimerEnd(_ sender: Any) {
        if let timer = mTimer {
            if(timer.isValid){
                timer.invalidate()
            }
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        let sendText: String = "\(countNum) times / \(number) sec"
        vc.receivedText = sendText
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
        txtTime.text = "0 sec"
        countLabel.text = "0 times"
        countNum = 0
        number = 0
        UIDevice.current.isProximityMonitoringEnabled = false
    }
    
    @objc func timerCallback(){
        number += 1
        txtTime.text = String(number)+" sec"
    }
    
    func proximitySensorActivation() {
        
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        countNum = 0
        if !firstCheck{
            firstCheck = true
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(didProximityStateChange),
                                                   name: UIDevice.proximityStateDidChangeNotification,
                                                   object: device)
        }
    }
    
    @objc func didProximityStateChange() {
        if UIDevice.current.proximityState {
            countNum += 1
            countLabel.text = String(countNum)+" times"
        }
    }
}

