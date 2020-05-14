//
//  MainVC.swift
//  Auth_with_firebase
//
//  Created by Maxim Granchenko on 14.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBAction func logOutButton() {
        performSegue(withIdentifier: "closeSegueWithSender", sender: self)
    }

}
