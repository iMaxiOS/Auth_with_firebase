//
//  ViewController.swift
//  Auth_with_firebase
//
//  Created by Maxim Granchenko on 14.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthVC: UIViewController {
    
    @IBAction func closeSegue(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func authButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "PhoneNumberVC") as! PhoneNumberVC
        present(dvc, animated: true, completion: nil)
    }
}

