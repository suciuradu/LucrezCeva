//
//  CreateAccountViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

class CreateAccountViewController: BasePhotoPickerViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var numeCompletTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var parolaTextField: UITextField!
    @IBOutlet weak var confirmareParolaTextField: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var viewModel: CreateAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
    }
    
    private func initUI() {
        setupBackButton()
        hideKeyboardWhenTappedAround()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        profilePictureImageView.image = #imageLiteral(resourceName: "default-profile-image")
        topView.applyGradient(withColours: [Colors.colorTopBlue, Colors.colorMediumTurqoise], gradientOrientation: .vertical)
        //NUME COMPLET
        numeCompletTextField.setBottomBorder(color: UIColor.black)
        numeCompletTextField.attributedPlaceholder = NSAttributedString(string: Strings.nume_complet, attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        
        //EMAIL
        emailTextField.setBottomBorder(color: UIColor.black)
        emailTextField.attributedPlaceholder = NSAttributedString(string: Strings.email, attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        
        //PAROLA
        parolaTextField.setBottomBorder(color: UIColor.black)
        parolaTextField.attributedPlaceholder = NSAttributedString(string: Strings.parola, attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        
        //CONFIRMARE PAROLA
        confirmareParolaTextField.setBottomBorder(color: UIColor.black)
        confirmareParolaTextField.attributedPlaceholder = NSAttributedString(string: Strings.confirmare_parola, attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        
        //PROFILE PICTURE
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped)))
    }
    
    private func initViewModel() {
        viewModel.createAccountSuccess.bind { (success) in
            if success {
                self.loadingIndicator.stopAnimating()
                self.viewModel.completeAccountTapped(fullName: self.numeCompletTextField.text!,
                                                     email: self.emailTextField.text!,
                                                     password: self.parolaTextField.text!,
                                                     image: self.profilePictureImageView.image ?? #imageLiteral(resourceName: "default-profile-image"))
            }
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupBackButton() {
        let back = UIBarButtonItem(image: #imageLiteral(resourceName: "back"),
                                     style: .plain,
                                     target: navigationController,
                                     action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = back
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc private func profilePictureTapped() {
        Logger.log("image tapped")
        showSelectOrCapturePhotoAlert(editImage: true)
    }
    
    override func onPhotoReady(_ image: UIImage) {
        profilePictureImageView.image = image
    }
    
    private func validateCredentials() -> Bool {
        if numeCompletTextField.text == "" {
            showErrorMessage("Completati numele dumneavoastra!")
            return false
        }
        if emailTextField.text == "" || !emailTextField.text!.isEmail {
            showErrorMessage("Completati emailul dumneavoastra!")
            return false
        }
        if parolaTextField.text?.count ?? 0 < 6 || !parolaTextField.text!.isValidPassword  {
            showErrorMessage("Parola trebuie sa contina cel putin o litera mare si o cifra!")
            return false
        }
        guard parolaTextField.text == confirmareParolaTextField.text else {
            showErrorMessage("Parolele nu coincid!")
            return false
        }
        return true
    }
    
    @IBAction func createAccounTapped(_ sender: Any) {
        if validateCredentials() {
            loadingIndicator.startAnimating()
            viewModel.createAccount(fullName: self.numeCompletTextField.text!,
                                    email: self.emailTextField.text!,
                                    password: self.parolaTextField.text!,
                                    confirmPassword: self.confirmareParolaTextField.text!)
        }
    }
}

protocol CreateAccountFlowDelegate: AnyObject {
    func createAccountTapped()
}
