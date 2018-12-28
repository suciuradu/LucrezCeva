//
//  LoginViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var parolaTextField: UITextField!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        hideKeyboardWhenTappedAround()
        emailTextField.attributedPlaceholder = NSAttributedString(string: Strings.email, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        parolaTextField.attributedPlaceholder = NSAttributedString(string: Strings.parola, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        viewModel.noAccountTapped()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        AppCoordinator.shared.showMain()
    }
    
}

protocol LoginFlowDelegate: AnyObject {
    func loginTapped()
    func noAccountTapped()
    func completeAccountTapped()
}
