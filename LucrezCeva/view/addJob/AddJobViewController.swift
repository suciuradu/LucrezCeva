//
//  AddJobViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit
import TagListView

class AddJobViewController: BaseViewController {
    
    @IBOutlet weak var jobTitleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addAbilitiesTextField: UITextField!
    @IBOutlet weak var addCityTextField: UITextField!
    @IBOutlet weak var addSalaryTextField: UITextField!
    @IBOutlet weak var jobTypeTags: TagListView!
    @IBOutlet weak var abilitiesTags: TagListView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        jobTypeTags.delegate = self
        abilitiesTags.delegate = self
        jobTitleTextView.delegate = self
        descriptionTextView.delegate = self
        addSalaryTextField.delegate = self

        jobTypeTags.addTags(["Zilnic","Săptămânal","Lunar","Ocazional"])
        if let font = UIFont(name: "AvenirNext-Demibold", size: 14) {
            jobTypeTags.textFont = font
        }
        if let font = UIFont(name: "AvenirNext-Demibold", size: 12) {
            abilitiesTags.textFont = font
        }
    }
    
    @IBAction func addAbilityTapped(_ sender: Any) {
        let tag = abilitiesTags.addTag(addAbilitiesTextField.text!)
        tag.enableRemoveButton = true
        tag.isSelected = true
    }
    
    @IBAction func postJobTapped(_ sender: Any) {
        
    }
    
}

extension AddJobViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == jobTitleTextView {
            if textView.textColor == Colors.colorLightWhite {
                textView.text = nil
                textView.textColor = UIColor.white
            }
        } else if textView == descriptionTextView {
            if textView.textColor == Colors.colorLightGray {
                textView.text = nil
                textView.textColor = Colors.colorDarkGray
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == jobTitleTextView {
            if textView.text.isEmpty {
                textView.text = "Completează titlul"
                textView.textColor = Colors.colorLightWhite
            }
        } else if textView == descriptionTextView {
            if textView.text.isEmpty {
                textView.text = "Completează descrierea"
                textView.textColor = Colors.colorLightGray
            }
        }
    }
}

extension AddJobViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if sender == jobTypeTags {
            let list = sender.tagViews
            for tag in list {
                if tag != tagView {
                    tag.isSelected = false
                    tag.enableRemoveButton = false
                } else {
                    tag.isSelected = true
                    tag.enableRemoveButton = true
                }
            }
        } else {
            if tagView.isSelected {
                tagView.isSelected = false
                tagView.enableRemoveButton = false
            } else {
                tagView.enableRemoveButton = true
                tagView.isSelected = true
            }
        }
    }
}
