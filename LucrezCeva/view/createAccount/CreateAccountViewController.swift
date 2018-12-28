//
//  CreateAccountViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountViewController: BasePhotoPickerViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var numeCompletTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var parolaTextField: UITextField!
    @IBOutlet weak var confirmareParolaTextField: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewContainerHeightConstraint: NSLayoutConstraint!
    
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
        let screenHeight = UIScreen.main.bounds.height
        topView.applyGradient(withColours: [Colors.colorTopBlue, Colors.colorMediumTurqoise], gradientOrientation: .vertical)
        topViewHeightConstraint.constant = screenHeight / 4
        imageViewContainerHeightConstraint.constant = screenHeight / 2
        
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
    
    
    @IBAction func createAccounTapped(_ sender: Any) {
        viewModel.completeAccountTapped()
    }
}

protocol CreateAccountFlowDelegate: AnyObject {
    func createAccountTapped()
}
