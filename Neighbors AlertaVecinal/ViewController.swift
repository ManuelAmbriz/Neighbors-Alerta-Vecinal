//
//  ViewController.swift
//  Neighbors AlertaVecinal
//
//  Created by Manuel Ambriz on 14/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let token = Messaging.messaging().fcmToken
        print("FCMViewContr  token: \(token ?? "")")
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogTokenTouch(_ sender: UIButton) {
        // [START log_fcm_reg_token]
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        // [END log_fcm_reg_token]
    }
    
    @IBAction func handleSubscribeTouch(_ sender: UIButton) {
        // [START subscribe_topic]
        Messaging.messaging().subscribe(toTopic: "news")
        print("Subscribed to news topic")
        // [END subscribe_topic]
    }
}

