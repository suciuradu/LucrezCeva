//
//  CompleteAccountViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 03/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit
import TagListView

class CompleteAccountViewController: BaseViewController {
    
    @IBOutlet weak var addTagBtn: UIButton!
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var jobTypeSwitch: UISegmentedControl!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var orasTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var abilitatiTextField: UITextField!
    @IBOutlet weak var abilitatiLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet var maiDeparteTelefonConstraint: NSLayoutConstraint!
    @IBOutlet var maiDeparteButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sexPicker: UISegmentedControl!
    
    private var datePicker: UIDatePicker!
    private var formatedDate: String?
    private var sexSelection = "Male"
    
    var viewModel: CompleteAccountViewModel!
    var fullName: String?
    var profilePictureImage: UIImage?
    var tagListWithStrings: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
    }
    
    private func initDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        let requestDateFormater = DateFormatter()
        requestDateFormater.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = "dd MM yyyy"
        formatedDate = requestDateFormater.string(from: datePicker.date)
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    private func initUI() {
        hideKeyboardWhenTappedAround()
        initDatePicker()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        tagList.delegate = self
        tagList.addTag("Abilitate")
        tagList.enableRemoveButton = false
        profilePicture.image = profilePictureImage
        fullNameLabel.text = fullName
        topView.applyGradient(withColours: [Colors.colorTopBlue, Colors.colorMediumTurqoise], gradientOrientation: .vertical)
        orasTextField.setBottomBorder(color: UIColor.black)
        orasTextField.attributedPlaceholder = NSAttributedString(string: "orasul", attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        phoneTextField.setBottomBorder(color: UIColor.black)
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "telefon", attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        abilitatiTextField.setBottomBorder(color: UIColor.black)
        abilitatiTextField.attributedPlaceholder = NSAttributedString(string: "abilitati", attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        dateTextField.setBottomBorder(color: UIColor.black)
        dateTextField.attributedPlaceholder = NSAttributedString(string: "alegeti data", attributes: [NSAttributedString.Key.foregroundColor: Colors.colorLightGray])
        dateTextField.inputView = datePicker
        maiDeparteTelefonConstraint.isActive = false
    }
    
    private func validateData() -> Bool {
        if dateTextField.text == "" {
            showErrorMessage("Selectati data nasterii!")
            return false
        }
        if orasTextField.text == "" {
            showErrorMessage("Va rugam sa introduceti orasul!")
            return false
        }
        if phoneTextField.text == "" || phoneTextField.text?.count ?? 0 < 10 {
            showErrorMessage("Va rugam sa introduceti numarul de telefon!")
            return false
        }
        return true
    }
    
    private func showAbilities(hidden: Bool) {
        abilitatiTextField.isHidden = hidden
        abilitatiLabel.isHidden = hidden
        tagList.isHidden = hidden
        addTagBtn.isHidden = hidden
        if hidden {
            maiDeparteTelefonConstraint.isActive = true
            maiDeparteTelefonConstraint.constant = 30
            maiDeparteButtonTopConstraint.isActive = false
        } else {
            maiDeparteTelefonConstraint.isActive = false
            maiDeparteButtonTopConstraint.isActive = true
        }
    }
    
    private func initViewModel() {
        viewModel.updateAccountSuccess.bind { (success) in
            if success {
                self.viewModel.loginTapped()
            } else {
                self.showErrorMessage("S-a produs o eroare!")
            }
        }
    }
    
    private func getSelectedTags() -> [String] {
        tagListWithStrings = [String]()
        for tag in tagList.selectedTags() {
            tagListWithStrings?.append((tag.titleLabel?.text) ?? "")
        }
        return tagListWithStrings ?? []
    }
    
    @IBAction func changeJobType(_ sender: Any) {
        switch jobTypeSwitch.selectedSegmentIndex {
        case 0:
            showAbilities(hidden: false)
        case 1:
            showAbilities(hidden: true)
        default:
            Logger.log("default")
        }
    }
    
    @IBAction func changeSexType(_ sender: Any) {
        switch sexPicker.selectedSegmentIndex {
        case 0:
            sexSelection = "Male"
            Logger.log("male")
        case 1:
            sexSelection = "Female"
            Logger.log("female")
        default:
            Logger.log("default sex")
        }
    }
    
    @IBAction func addTagPressed(_ sender: Any) {
        let tag = tagList.addTag(abilitatiTextField.text!)
        tag.enableRemoveButton = true
        tag.isSelected = true
    }
    
    @IBAction func creeazaContTapped(_ sender: Any) {
        if validateData() {
            tagListWithStrings = getSelectedTags()
            if jobTypeSwitch.selectedSegmentIndex != 0 {
                tagListWithStrings = []
            }
            viewModel.updateAccountDetails(birthDay: formatedDate!, location: orasTextField.text!, gender: sexSelection, phone: phoneTextField.text!, tags: tagListWithStrings ?? [])
        }
    }
}

extension CompleteAccountViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if tagView.isSelected {
            tagView.isSelected = false
            tagView.enableRemoveButton = false
        } else {
            tagView.enableRemoveButton = true
            tagView.isSelected = true
        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
    }
}
