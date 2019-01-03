//
//  LoginViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var parolaTextField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
    }
    
    private func initUI() {
        hideKeyboardWhenTappedAround()
        emailTextField.attributedPlaceholder = NSAttributedString(string: Strings.email, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        parolaTextField.attributedPlaceholder = NSAttributedString(string: Strings.parola, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func initViewModel() {
        viewModel.loginSuccess.bind { (success) in
            if success {
                self.loadingIndicator.stopAnimating()
                AppCoordinator.shared.showMain()
            } else {
                self.showErrorMessage("Emailul sau parola dumneavoastra nu sunt corecte!")
            }
        }
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        viewModel.noAccountTapped()
        loadingIndicator.startAnimating()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if validateCredentials() {
            viewModel.login(username: emailTextField.text!, password: parolaTextField.text!)
        }
        
    }
    
    private func validateCredentials() -> Bool {
        if emailTextField.text == "" || !emailTextField.text!.isEmail {
            showErrorMessage("Completati emailul!")
            return false
        }
        if parolaTextField.text == "" {
            showErrorMessage("Completati parola!")
            return false
        }
        return true
    }
    
}

protocol LoginFlowDelegate: AnyObject {
    func loginTapped()
    func noAccountTapped()
    func completeAccountTapped(name: String, email: String, password: String, image: UIImage)
}
