//
//  CompleteAccountViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 03/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit
import TagListView

class CompleteAccountViewController: UIViewController {
    
    @IBOutlet weak var addTagBtn: UIButton!
    @IBOutlet weak var addTagTextField: UITextField!
    @IBOutlet weak var tagList: TagListView!
    
    @IBAction func addTagPressed(_ sender: Any) {
        let tag = tagList.addTag(addTagTextField.text!)
        tag.enableRemoveButton = true
        tag.isSelected = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagList.delegate = self
        tagList.addTag("cevaa")
        tagList.addTag("cevaa1")
        tagList.addTag("cevaa2")
        tagList.addTag("cevaa")
        tagList.enableRemoveButton = false
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
