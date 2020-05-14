//
//  CodeValidVC.swift
//  Auth_with_firebase
//
//  Created by Maxim Granchenko on 14.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class CodeValidVC: UIViewController {
    
    @IBOutlet weak var checkCodeBtn: UIButton!
    @IBOutlet weak var codeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEnableButton()
        configurCodeTextView()
    }
    
    @IBAction func checkCodeButton() {
        showMainVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeTextView.becomeFirstResponder()
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
