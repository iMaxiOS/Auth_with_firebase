//
//  CodeValidVC.swift
//  Auth_with_firebase
//
//  Created by Maxim Granchenko on 14.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit
import FirebaseAuth

class CodeValidVC: UIViewController {
    
    @IBOutlet weak var checkCodeBtn: UIButton!
    @IBOutlet weak var codeTextView: UITextView!
    
    public var verificationID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEnableButton()
        configurCodeTextView()
    }
    
    @IBAction func checkCodeButton() {
        guard let code = codeTextView.text else { return }
        let credetinal = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        Auth.auth().signIn(with: credetinal) { [weak self] _, error in
            guard let self = self else { return }
            if error != nil {
                self.createAlertController(with: error)
            } else {
                self.showMainVC()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeTextView.becomeFirstResponder()
    }
    
    private func createAlertController(with error: Error?) {
        let alertC = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
        alertC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertC, animated: true)
    }
    
    private func showMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "MainVC") as! MainVC
        self.present(dvc, animated: true, completion: nil)
    }
    
    private func configureEnableButton() {
        checkCodeBtn.alpha = 0.5
        checkCodeBtn.isEnabled = false
    }
    
    private func configureShowButton() {
        checkCodeBtn.alpha = 1.0
        checkCodeBtn.isEnabled = true
    }
    
    private func configurCodeTextView() {
        codeTextView.delegate = self
    }
    
}

extension CodeValidVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let current = textView.text?.count ?? 0
        if range.length + range.location > current {
            return false
        }
        let newLenght = current + text.count - range.length
        return newLenght <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 6 {
            configureShowButton()
        } else {
            configureEnableButton()
        }
    }
    
}
