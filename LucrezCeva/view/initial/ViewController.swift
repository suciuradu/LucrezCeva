//
//  ViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let app = Storyboards.login.instantiate(controller: LoginViewController.self)
        present(app, animated: true, completion: nil)
    }

}

