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
    @IBOutlet weak var addTagTextField: UITextField!
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var jobTypeSwitch: UISegmentedControl!
    
    var viewModel: CompleteAccountViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
    }
    
    private func initUI() {
        hideKeyboardWhenTappedAround()
        tagList.delegate = self
        tagList.addTag("cevaa")
        tagList.addTag("cevaa1")
        tagList.addTag("cevaa2")
        tagList.addTag("cevaa")
        tagList.enableRemoveButton = false
    }
    
    private func initViewModel() {
        //viewModel = CompleteAccountViewModel()
    }
    
    @IBAction func changeJobType(_ sender: Any) {
        switch jobTypeSwitch.selectedSegmentIndex {
        case 1:
            Logger.log("case 1")
        case 2:
            Logger.log("case 2")
        default:
            Logger.log("default")
        }
    }
    
    @IBAction func addTagPressed(_ sender: Any) {
        let tag = tagList.addTag(addTagTextField.text!)
        tag.enableRemoveButton = true
        tag.isSelected = true
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func creeazaContTapped(_ sender: Any) {
        viewModel.loginTapped()
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
