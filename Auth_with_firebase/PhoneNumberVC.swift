//
//  PhoneNumberVC.swift
//  Auth_with_firebase
//
//  Created by Maxim Granchenko on 14.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class PhoneNumberVC: UIViewController {
    
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var getCodeBtn: UIButton!
    
    private let listController = FPNCountryListViewController(style: .grouped)
    
    private var phoneNumber: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureEnableButton()
        configureTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phoneTextField.becomeFirstResponder()
    }
    
    @IBAction func getCodeButton() {
        showCodeValidVC()
    }
    
    private func showCodeValidVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "CodeValidVC") as! CodeValidVC
        self.present(dvc, animated: true, completion: nil)
    }
    
    private func configureEnableButton() {
        getCodeBtn.alpha = 0.5
        getCodeBtn.isEnabled = false
    }
    
    private func configureShowButton() {
        getCodeBtn.alpha = 1.0
        getCodeBtn.isEnabled = true
    }
    
    private func configureTextField() {
        phoneTextField.setFlag(key: .UA)
        phoneTextField.displayMode = .list
        phoneTextField.flagButtonSize = .init(width: 50, height: 50)
        phoneTextField.delegate = self
        
        listController.setup(repository: phoneTextField.countryRepository)
        listController.didSelect = { country in
            self.phoneTextField.setFlag(countryCode: country.code)
        }
    }

}

extension PhoneNumberVC: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            configureShowButton()
            
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            configureEnableButton()
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Country"
        self.present(navigationViewController, animated: true, completion: nil)
    }
}
